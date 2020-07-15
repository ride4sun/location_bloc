import 'package:equatable/equatable.dart';
import 'package:location_bloc/model/units/unit.dart';

class Degree extends Unit implements Equatable {
  final double _degree;

  @override
  String get unit => '°';

  @override
  String get value => _degree.toStringAsFixed(1);

  Degree.fromNumber({double value: 0.0}) : _degree = value;

  int compareTo(Degree other) => _degree.compareTo(other._degree);

  @override
  List<Object> get props => [value];

  @override
  bool get stringify => true;
}
