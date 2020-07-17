import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_bloc/location_bloc.dart';
import 'package:location_bloc_example/location_screen.dart';

void main() {
  Bloc.observer = LocationBlocObserver();
  runApp(LocationBlocExampleApp());
}

class LocationBlocExampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Bloc Example',
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        buttonTheme: new ThemeData.dark().buttonTheme.copyWith(
            buttonColor: Colors.orange.shade500,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
        unselectedWidgetColor: Colors.orange.shade800,
        toggleableActiveColor: Colors.orange.shade800,
        primaryColor: Colors.orange.shade500,
        primaryColorLight: Colors.amber.shade200,
        primaryColorDark: Colors.orange.shade800,
        accentColor: Colors.orange.shade500,
        splashColor: Colors.deepOrange.shade500,
        textSelectionColor: Colors.orange.shade500,
        cursorColor: Colors.orange.shade800,
        textSelectionHandleColor: Colors.orange.shade800,
        backgroundColor: Colors.orange.shade100,
        iconTheme: IconThemeData(
          color: Colors.orange.shade500,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 22.0,
          shape: RoundedRectangleBorder(),
        ),
      ),
      home: BlocProvider(
        create: (BuildContext context) => LocationBloc(LocationState.stoped()),
        child: LocationScreen(),
      ),
    );
  }
}
