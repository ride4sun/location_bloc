import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:location_bloc/model/units/unit.dart';

class Degree extends Unit implements Equatable {
  final double degree;
  final int precision;

  @override
  String get unit => '°';

  @override
  String get value => degree.toStringAsFixed(precision);

  Degree.fromNumber({@required this.degree, this.precision = 1});

  int compareTo(Degree other) => degree.compareTo(other.degree);

  @override
  List<Object> get props => [degree];

  @override
  bool get stringify => true;
}
