import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:location/location.dart' as ploc;
import 'package:location_bloc/bloc/location_event.dart';
import 'package:location_bloc/bloc/location_state.dart';
import 'package:location_bloc/extensions/extensions.dart';
import 'package:location_bloc/model/model.dart' as mo;

enum gpsError {
  noError,
  permissionDenied,
  permissionDeniedNeverAsk,
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(LocationState initialState) : super(initialState);

  final location = ploc.Location();
  final StreamController<LocationState> stateController =
      StreamController<LocationState>(onListen: () {
    //debugger(when: true);
  }, onPause: () {
    //debugger(when: true);
  }, onResume: () {
    //debugger(when: true);
  }, onCancel: () {
    //debugger(when: true);
  });

  StreamSubscription _locationSubscription;
  mo.UnitSystem _system = mo.UnitSystem.Metrics;

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugger(when: true);
  }

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) {
    event.when(
      setUnitSystem: (args) => _setUnitSystem(args),
      start: (_) => _start(),
      stop: (_) => _stop(),
    );

    return stateController.stream;
  }

  _setUnitSystem(SetUnitSystem args) async {
    _system = args.unitSystem;
    if (state is SendData)
      stateController.add(
        LocationState.sendData(
          location: updateLocation(
            await location.getLocation(),
          ),
        ),
      );
  }

  Future _start() async {
    if (_locationSubscription.isNotNull) return;
    ploc.PermissionStatus permission = await location.hasPermission();
    if (permission != ploc.PermissionStatus.granted) {
      permission = await location.requestPermission();

      if (permission != ploc.PermissionStatus.granted) {
        stateController.add(LocationState.error(
            info: 'Location Service has no permission. '
                'Please check settings',
            results: gpsError.permissionDenied));
        return;
      }
    }

    bool enabled = await location.serviceEnabled();

    if (enabled.isFalse) {
      bool enabled = await location.requestService();
      if (enabled.isFalse) {
        stateController.add(
          LocationState.error(
              info: 'Location not active.'
                  'Please check your settings',
              results: gpsError.permissionDenied),
        );
        return;
      }
    }

    await ploc.Location()
        .changeSettings(accuracy: ploc.LocationAccuracy.high, interval: 1);

    _locationSubscription = location.onLocationChanged.listen(
      (data) {
        if (location.isNotNull) {
          stateController.add(
            LocationState.sendData(
              location: updateLocation(data),
            ),
          );
        }
      },
    );

    _locationSubscription.onError((err) async {
      await _handleError(err);
      await _locationSubscription.cancel();
      _locationSubscription = null;
    });

    //send one initial update to change state
    stateController.add(
      LocationState.sendData(
        location: updateLocation(
          await ploc.Location().getLocation(),
        ),
      ),
    );
  }

  Future _handleError(dynamic error) async {
    if (error.code == 'PERMISSION_DENIED') {
      stateController.add(LocationState.error(
          info: 'Permission Denied', results: gpsError.permissionDenied));
    } else if (error.code == 'PERMISSION_DENIED_NEVER_ASK') {
      stateController.add(LocationState.error(
          info: 'Permission Denied',
          results: gpsError.permissionDeniedNeverAsk));
    } else {
      stateController.add(LocationState.error(
          info: 'Could not get Location ',
          results: gpsError.permissionDeniedNeverAsk));
    }
  }

  Future _stop() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
    stateController.add(LocationState.stoped());
  }

  mo.Location updateLocation(ploc.LocationData data) => mo.Location(
      altitude: mo.Altitude.fromMeters(value: data.altitude, system: _system),
      speed: mo.Speed.fromMeterPerSecond(value: data.speed, system: _system),
      accuracy: mo.Length.fromMeters(value: data.accuracy, system: _system),
      heading: data.heading,
      latitude: data.latitude,
      longitude: data.longitude,
      speedAccuracy:
          mo.Length.fromMeters(value: data.speedAccuracy, system: _system));

//  Future dispose() async {
//    await _locationSubscription?.cancel();
//    await this.drain();
//    await this.close();
//    _locationSubscription = null;
//  }
}
