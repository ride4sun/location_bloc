import 'package:location_bloc/model/units/unit_system.dart';

abstract class Unit {
  String get unit => '';
  String get value => '0';
  double convertIn(UnitSystem system) => double.parse(value);
  @override
  String toString() => '$value $unit';
}
