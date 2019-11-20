import 'package:flutter/material.dart';
import 'package:potato_fries/pages/fries_page.dart';
import 'package:potato_fries/widgets/clock_face_picker.dart';

class LockScreen extends StatelessWidget{
  final title = "Lock Screen";
  final icon = Icons.lock;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FriesPage(
      title: title,
      children: <Widget>[
        ClockFacePicker(),
      ],
    );
  }
}