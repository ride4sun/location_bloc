import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_bloc/Location_bloc.dart';
import 'package:location_bloc_example/misc/button.dart';
import 'package:location_bloc_example/misc/margins.dart';

class Value {
  Value({this.description, this.unit});
  final String description;
  final String unit;
}

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: buildLocationWidget(context));

  Widget buildLocationWidget(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Margins(
                all: 40,
                child: _buildButton(
                  context,
                  BlocProvider.of(context),
                ),
              ),
            ),
            Expanded(
                child: _buildLocationValueDisplay(
                    context, BlocProvider.of(context))),
          ],
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, LocationBloc bloc) {
    if (bloc.state is Stoped)
      return Margins(
        top: 30,
        child:
            Button(text: 'Start', onTap: () => bloc.add(LocationEvent.start())),
      );
    else if (bloc.state is SendData)
      return Margins(
        top: 30,
        child:
            Button(text: 'Stop', onTap: () => bloc.add(LocationEvent.stop())),
      );
    else if (bloc.state is Error) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Margins(
              top: 30,
              child: Button(
                  text: 'Start', onTap: () => bloc.add(LocationEvent.start())),
            ),
            Text('${bloc.state}')
          ]);
    } else
      throw ArgumentError('Unknown State - implement!');
  }

  Widget _buildLocationValueDisplay(BuildContext context, LocationBloc bloc) {
    if (!(bloc.state is SendData))
      return Container();
    else {
      var location = (bloc.state as SendData).location;

      var valueWidgets = [
        Value(description: 'Longitude', unit: location.longitude.toString()),
        Value(description: 'Latitude', unit: location.latitude.toString()),
        Value(description: 'Accuracy', unit: location.accuracy.toString()),
        Value(description: 'Altitude', unit: location.altitude.toString()),
        Value(description: 'Speed', unit: location.speed.toString()),
        Value(
            description: 'Speed Accuracy',
            unit: location.speedAccuracy.toString()),
        Value(description: 'Date Time', unit: location.dateTime.toString()),
      ]
          .map(
            (e) => Margins(
              all: 10,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(e.description), Text(e.unit)],
              ),
            ),
          )
          .toList();

      return Column(children: valueWidgets);
    }
  }
}
