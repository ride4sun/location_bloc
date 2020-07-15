import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_bloc/Location_bloc.dart';
import 'package:location_bloc_example/misc/button.dart';
import 'package:location_bloc_example/misc/margins.dart';

class LocationValueScreen extends StatelessWidget {
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
                all: 20,
                child: _buildButton(
                  context,
                  BlocProvider.of(context),
                ),
              ),
            ),
            Expanded(
                child: _buildPositionDataDisplay(
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

  Widget _buildPositionDataDisplay(BuildContext context, LocationBloc bloc) {
    if (!(bloc.state is SendData))
      return Container();
    else {
      var location = (bloc.state as SendData).location;

      return Column(
        children: <Widget>[
//          UnitSelection(),
          Margins(
            all: 10,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Longitude'),
                Text('${location.longitude}')
              ],
            ),
          ),
          new Margins(
              all: 10,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Latitude'),
                  Text('${location.latitude}')
                ],
              )),
          new Margins(
            all: 10,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('accuracy'),
                Text('${location.accuracy}')
              ],
            ),
          ),
          new Margins(
            all: 10,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('altitude'),
                Text('${location.altitude}')
              ],
            ),
          ),
          new Margins(
            all: 10,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text('Speed'), Text('${location.speed}')],
            ),
          ),
          new Margins(
            all: 10,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Speed Accuracy'),
                Text('${location.speedAccuracy}')
              ],
            ),
          ),
          new Margins(
              all: 10,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Heading'),
                  Text('${location.heading}')
                ],
              )),
          new Margins(
            all: 10,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Time'),
                Text(
                  '${location.dateTime}',
                )
              ],
            ),
          ),
        ],
      );
    }
  }
}
