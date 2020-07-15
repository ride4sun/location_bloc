import 'package:equatable/equatable.dart';
import 'package:location_bloc/model/units/altitude.dart';
import 'package:location_bloc/model/units/length.dart';
import 'package:location_bloc/model/units/speed.dart';
import 'package:location_bloc/model/units/unit_system.dart';
import 'package:meta/meta.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;
  final Length accuracy;
  final Altitude altitude;
  final Speed speed;
  final Length speedAccuracy;
  final double heading;
  final String dateTime;
  final UnitSystem measurementSystem;

  DateTime get timeStamp => DateTime.parse(dateTime);

  Location({
    @required this.latitude,
    @required this.longitude,
    @required this.accuracy,
    @required this.altitude,
    @required this.speed,
    @required this.speedAccuracy,
    @required this.heading,
    this.measurementSystem = UnitSystem.Metrics,
  }) : dateTime = DateTime.now().toIso8601String();

  Location._internal(
      {@required this.measurementSystem,
      @required this.latitude,
      @required this.longitude,
      @required this.accuracy,
      @required this.altitude,
      @required this.speed,
      @required this.speedAccuracy,
      @required this.heading,
      @required this.dateTime});

  //all in si base units - e.g. meters
  Map<String, dynamic> toMap() => {
        'latitude': '${latitude ?? 0}',
        'longitude': '${longitude ?? 0}',
        'accuracy': '${accuracy.inMeters ?? 0}',
        'altitude': '${altitude.inMeters ?? 0}',
        'speed': '${speed.inMeterPerSecond ?? 0}',
        'speedAccuracy': '${speedAccuracy.inMeters ?? 0}',
        'heading': '${heading ?? 0}',
        'dateTime': '${dateTime ?? 0}'
      };

  factory Location.fromMap(
      {@required Map<String, dynamic> dataMap,
      UnitSystem system = UnitSystem.Metrics}) {
    return Location._internal(
      measurementSystem: system,
      latitude: double.parse(dataMap['latitude'] ?? 0),
      longitude: double.parse(dataMap['longitude'] ?? 0),
      accuracy:
          Length.fromMeters(value: double.parse(dataMap['accuracy'] ?? 0)),
      altitude:
          Altitude.fromMeters(value: double.parse(dataMap['altitude'] ?? 0)),
      speed:
          Speed.fromMeterPerSecond(value: double.parse(dataMap['speed'] ?? 0)),
      speedAccuracy:
          Length.fromMeters(value: double.parse(dataMap['speedAccuracy'] ?? 0)),
      heading: double.parse(dataMap['heading'] ?? 0),
      dateTime: dataMap['dateTime'] ?? DateTime.now().toIso8601String(),
    );
  }

  @override
  String toString() => 'latitude: ${latitude ?? '--'}\n'
      'longitude: ${longitude ?? '--'}\n'
      'accuracy: ${accuracy ?? '--'}\n'
      'altitude: ${altitude ?? '--'}\n'
      'speed: ${speed ?? '--'}\n'
      'speedAccuracy: ${speedAccuracy ?? '--'}\n'
      'heading: ${heading ?? '--'}\n'
      'dateTime: ${timeStamp ?? '--'}\n';

  @override
  List<Object> get props => [
        this.measurementSystem,
        this.latitude,
        this.longitude,
        this.accuracy,
        this.altitude,
        this.speed,
        this.speedAccuracy,
        this.heading,
        this.dateTime
      ];
}
