import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:location_bloc/model/units/unit.dart';
import 'package:location_bloc/model/units/unit_system.dart';
import 'package:meta/meta.dart';

class Speed extends Unit implements Equatable {
  ///meters per second to:
  static const double _msec_to_kmh = 3.6;
  static const double _msec_to_mih = 2.23693629;
  static const double _msec_to_knot = 1.94384449;

  ///other measurements to meters per second
  static const double _kmh_to_msec = 0.27777777777778;
  static const double _mih_to_msec = 0.44704;
  static const double _knot_to_msec = 0.514444444;

  /*
   * The value of this Speed object in m/s = meter per second .
   */
  final double _speed;

  Speed.fromMeterPerSecond(
      {@required double value, this.system = UnitSystem.Metrics})
      : _speed = value;
  Speed.fromKilometerPerHour(
      {@required double value, this.system = UnitSystem.Metrics})
      : _speed = _kmh_to_msec * value;
  Speed.fromMilePerHour(
      {@required double value, this.system = UnitSystem.Metrics})
      : _speed = _mih_to_msec * value;
  Speed.fromKnot({@required double value, this.system = UnitSystem.Metrics})
      : _speed = _knot_to_msec * value;

  @override
  double convertIn(UnitSystem system) => double.parse(_convert(system));

  @override
  String get unit => system == UnitSystem.Metrics ? 'km/h' : 'mph';
  @override
  String get value => _convert(system);

  String _convert(UnitSystem system) => system == UnitSystem.Metrics
      ? inKilometerPerHour.toStringAsFixed(0)
      : inMilePerHour.toStringAsFixed(0);

  double get inMeterPerSecond => _returnValueOrZero(_speed);
  double get inKilometerPerHour => _returnValueOrZero(_msec_to_kmh * _speed);
  double get inMilePerHour => _returnValueOrZero(_msec_to_mih * _speed);
  double get inKnot => _returnValueOrZero(_msec_to_knot * _speed);
  final UnitSystem system;
  double _returnValueOrZero(double value) =>
      value >= 0.0 ? double.parse(value.toStringAsFixed(6)) : 0.0;

  @override
  List<Object> get props => [value];

  @override
  bool get stringify => true;
}
