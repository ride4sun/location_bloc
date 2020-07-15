//import 'package:flutter/material.dart';
//
//import 'location_bloc.dart';
//
//class LocationBlocProvider extends InheritedWidget {
//  final bloc = LocationBloc();
//
//  LocationBlocProvider({Key key, Widget child}) : super(key: key, child: child);
//
//  bool updateShouldNotify(_) => true;
//
//  static LocationBloc of(BuildContext context) {
//    return context
//        .dependOnInheritedWidgetOfExactType<LocationBlocProvider>()
//        .bloc;
//  }
//}
