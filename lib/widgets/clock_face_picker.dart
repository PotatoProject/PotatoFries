import 'package:flutter/material.dart';

class ClockFacePicker extends StatefulWidget {
  @override
  _ClockFacePickerState createState() => _ClockFacePickerState();
}

class _ClockFacePickerState extends State<ClockFacePicker> {
  String dropDownValue = "Default";

  _defaultClock() {
    return FittedBox(
      child: Text("12:25"),
    );
  }

  _typeClock() {
    return FittedBox(
      child: Text("     Twelve\n Twenty Five"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (dropDownValue == 'Default')
          ? _defaultClock()
          : ((dropDownValue == 'Bubble')
              ? Icon(Icons.bubble_chart)
              : (dropDownValue == 'Analog')
                  ? Icon(Icons.timer)
                  : (dropDownValue == 'Type') ? _typeClock() : Container()),
      title: Text("Clock face"),
      subtitle: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: DropdownButton<String>(
                value: dropDownValue,
                items: <String>['Default', 'Bubble', 'Analog', 'Type']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValue = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
