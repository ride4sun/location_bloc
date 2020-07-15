import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_bloc/location_bloc.dart';

void main() {
  runApp(LocationBlocExampleApp());
}

class LocationBlocExampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Bloc Example',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: BlocProvider(
        create: (BuildContext context) => LocationBloc(LocationState.stoped()),
        child: LocationScreen(),
      ),
    );
  }
}
