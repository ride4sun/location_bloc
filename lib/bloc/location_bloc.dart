import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:location/location.dart' as ploc;
import 'package:location/location.dart';
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

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    yield* event.when(
      setUnitSystem: (args) => _setUnitSystem(args),
      start: (_) => _start(),
      stop: (_) => _stop(),
    );
  }

  Stream<LocationState> _setUnitSystem(SetUnitSystem args) async* {
    _system = args.unitSystem;
    if (state is SendData)
      yield LocationState.sendData(
          location: updateLocation(await location.getLocation()));
    else
      yield state;
  }

  Stream<LocationState> _start() async* {
    if (_locationSubscription.isNotNull) return;

    PermissionStatus permission = await location.hasPermission();
    if (permission != PermissionStatus.granted) {
      permission = await location.requestPermission();

      if (permission != PermissionStatus.granted) {
        yield LocationState.error(
            info: 'Location Service has no permission. '
                'Please check settings',
            results: gpsError.permissionDenied);
        return;
      }
    }

    bool enabled = await location.serviceEnabled();

    if (enabled.isFalse) {
      bool enabled = await location.requestService();
      if (enabled.isFalse) {
        yield LocationState.error(
            info: 'Location not active.'
                'Please check your settings',
            results: gpsError.permissionDenied);
        return;
      }
    }

//    await ploc.Location()
//        .changeSettings(accuracy: ploc.LocationAccuracy.high, interval: 1);

    _locationSubscription = location.onLocationChanged.listen(
      (location) async* {
        if (location.isNotNull) {
          yield LocationState.sendData(location: updateLocation(location));
        }
      },
    );

    _locationSubscription.onError((err) async* {
      yield _handleError(err);
      _locationSubscription.cancel();
    });

    //send one initial update to change state
    yield LocationState.sendData(
        location: updateLocation(await ploc.Location().getLocation()));
  }

  Stream<LocationState> _handleError(dynamic error) async* {
    if (error.code == 'PERMISSION_DENIED') {
      yield LocationState.error(
          info: 'Permission Denied', results: gpsError.permissionDenied);
    } else if (error.code == 'PERMISSION_DENIED_NEVER_ASK') {
      yield LocationState.error(
          info: 'Permission Denied',
          results: gpsError.permissionDeniedNeverAsk);
    } else {
      yield LocationState.error(
          info: 'Could not get Location ',
          results: gpsError.permissionDeniedNeverAsk);
    }
  }

  Stream<LocationState> _stop() async* {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
    yield LocationState.stoped();
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

  Future dispose() async {
    await _locationSubscription?.cancel();
    await this.drain();
    await this.close();
    _locationSubscription = null;
  }

  StreamSubscription _locationSubscription;
  mo.UnitSystem _system = mo.UnitSystem.Metrics;
}
