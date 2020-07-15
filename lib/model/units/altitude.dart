import 'package:equatable/equatable.dart';
import 'package:location_bloc/model/units/length.dart';
import 'package:location_bloc/model/units/unit.dart';
import 'package:location_bloc/model/units/unit_system.dart';
import 'package:meta/meta.dart';

class Altitude extends Unit implements Equatable {
  Altitude.fromMeters(
      {@required double value, this.system = UnitSystem.Metrics})
      : _length = Length.fromMeters(value: value);

  final Length _length;
  final UnitSystem system;

  List<Object> get props => [_length];
  bool get stringify => true;

  String get unit => system == UnitSystem.Metrics ? 'm' : 'ft';
  String get value => system == UnitSystem.Metrics
      ? inMeters
      : _length.inFeet.toStringAsFixed(1);

  String get inMeters => _length.inMeters.toStringAsFixed(2);
  String get inFeet => _length.inMeters.toStringAsFixed(1);
}
