import 'package:equatable/equatable.dart';
import 'package:location_bloc/model/units/unit.dart';
import 'package:location_bloc/model/units/unit_system.dart';

class Length extends Unit implements Equatable {
  ///meters to kilometers: meters * 10^-3
  static const double _m_to_km = 0.001;

  /// meters to miles: meters * 6.21371192 * 10^-4
  static const double _m_to_mi = 6.21371192 * 0.0001;

  /// meters to feet: meters * 3.28084
  static const double _m_to_ft = 3.28084;

  ///kilometers to meters: km * 10^3
  static const double _km_to_m = 1000.0;

  ///miles to meters: mi * 1.6093440 * 10^3
  static const double _mi_to_m = 1.6093440 * 1000;

  ///feet to meters: ft /  3.28084
  static const double _ft_to_m = 1 / 3.28084;
  /*
   * The value of this Length object in meters.
   */
  final double _length;

  final int fractionDigitsMetric;
  final int fractionDigitsSAE;

  Length.fromMeters(
      {double value: 0.0,
      this.system = UnitSystem.Metrics,
      this.fractionDigitsMetric: 2,
      this.fractionDigitsSAE: 2})
      : _length = value;
  Length.fromKilometers(
      {double value: 0.0,
      this.system = UnitSystem.Metrics,
      this.fractionDigitsMetric: 2,
      this.fractionDigitsSAE: 2})
      : _length = value * _km_to_m;
  Length.fromMiles(
      {double value: 0.0,
      this.system = UnitSystem.Metrics,
      this.fractionDigitsMetric: 2,
      this.fractionDigitsSAE: 2})
      : _length = value * _mi_to_m;
  Length.fromFeet(
      {double value: 0.0,
      this.system = UnitSystem.Metrics,
      this.fractionDigitsMetric: 2,
      this.fractionDigitsSAE: 2})
      : _length = value / _ft_to_m;
  final UnitSystem system;

  String get unit => system == UnitSystem.Metrics ? 'km' : 'miles';
  String get value => roundValue();

  String roundValue() {
    return system == UnitSystem.Metrics
        ? inKilometers.toStringAsFixed(fractionDigitsMetric)
        : inMiles.toStringAsFixed(fractionDigitsSAE);
  }

  @override
  String toString() => '$value $unit';

  double get inMeters => _returnValueOrZero(_length);
  double get inKilometers => _returnValueOrZero(_length * _m_to_km);
  double get inMiles => _returnValueOrZero(_length * _m_to_mi);
  double get inFeet => _returnValueOrZero(_length * _m_to_ft);
  double _returnValueOrZero(num value) => value >= 0.0
      ? double.parse(value.toStringAsFixed(fractionDigitsMetric))
      : 0.0;

  String get inMetersString => '$inMeters m';
  String get inKilometersString => '$inKilometers km';
  String get inMilesString => '$inMiles miles';
  String get inFeetString => '$inFeet ft';
  String get inMeterOrFeet =>
      this.system == UnitSystem.Metrics ? inMetersString : inFeetString;
  @override
  List<Object> get props => [value];

  @override
  bool get stringify => true;
}
