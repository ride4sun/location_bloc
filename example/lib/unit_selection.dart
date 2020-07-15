//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:location_bloc/location_bloc.dart';
//
//class UnitSelection extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return buildUnitsSettings(context);
//  }
//
//  Widget buildUnitsSettings(BuildContext context) => new ExpansionTile(
//        title: Text('Units'),
//        trailing: Container(child: _buildUnitsSelection(context), width: 120),
//      );
//
//  Widget _buildUnitsSelection(BuildContext context) {
//    return StreamBuilder<UnitSystem>(
//      stream: BlocProvider.of(context).settings.units.stream,
//      builder: (BuildContext context, AsyncSnapshot selectedUnits) {
//        return (selectedUnits != null && selectedUnits.hasData)
//            ? buildUnitsDropdown(getUnitStrings(), selectedUnits, context)
//            : Container();
//      },
//    );
//  }
//
//  Widget buildUnitsDropdown(
//      List<String> units, AsyncSnapshot selectedUnits, BuildContext context) {
//    return DropdownButton<String>(
//        value: selectedUnits.data.toString().split('.').last,
//        onChanged: (unit) {
//          BlocProvider.of(context)
//              .settings
//              .unitsSink
//              .add(fromUnitStringEnumValue(unit));
//        },
//        items: units.map<DropdownMenuItem<String>>(
//          (String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          },
//        ).toList());
//  }
//}
