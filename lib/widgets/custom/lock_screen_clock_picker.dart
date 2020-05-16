import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/provider/themes.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:provider/provider.dart';

class LockScreenClockPicker extends StatefulWidget {
  @override
  _LockScreenClockPickerState createState() => _LockScreenClockPickerState();
}

class _LockScreenClockPickerState extends State<LockScreenClockPicker> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PageProvider>(context) as ThemesProvider;
    String curClock = provider.getLSClockData();
    return SizeableListTile(
      title: 'Lock Screen Clock',
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Lock Screen Clock',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ClockOptions(provider),
                  ],
                ),
              );
            });
      },
      icon: Icon(MdiIcons.lockClock),
      subtitle: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: lockClocks.keys.map((t) {
          return AnimatedOpacity(
            opacity: t == curClock ? 1 : 0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Text(t),
          );
        }).toList(),
      ),
    );
  }
}

class ClockOptions extends StatelessWidget {
  final ThemesProvider provider;

  ClockOptions(this.provider);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Builder(
        builder: (context) {
          var provider = Provider.of<ThemesProvider>(context);
          String curClock = provider.getLSClockData();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClockPreviewWrapper(
                child: DefaultClockPreview(),
                title: lockClocks.keys.toList()[0],
                enabled: curClock == lockClocks.keys.toList()[0],
              ),
              ClockPreviewWrapper(
                child: BubbleClockPreview(),
                title: lockClocks.keys.toList()[1],
                enabled: curClock == lockClocks.keys.toList()[1],
              ),
              ClockPreviewWrapper(
                child: AnalogClockPreview(),
                title: lockClocks.keys.toList()[2],
                enabled: curClock == lockClocks.keys.toList()[2],
              ),
              ClockPreviewWrapper(
                child: TypeClockPreview(),
                title: lockClocks.keys.toList()[3],
                enabled: curClock == lockClocks.keys.toList()[3],
              ),
            ],
          );
        },
      ),
    );
  }
}

class ClockPreviewWrapper extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final String title;

  ClockPreviewWrapper({this.title, this.child, this.enabled = false});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemesProvider>(context);
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => provider.setLSClockData(title),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: Theme.of(context).accentColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              color: Colors.transparent,
            ),
            child: child,
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: InputChip(
            avatar: enabled
                ? Icon(
                    Icons.check,
                    color: enabled
                        ? Theme.of(context).scaffoldBackgroundColor
                        : null,
                  )
                : null,
            isEnabled: true,
            label: Text(
              title,
              style: enabled
                  ? TextStyle(color: Theme.of(context).scaffoldBackgroundColor)
                  : null,
            ),
            backgroundColor: enabled ? Theme.of(context).accentColor : null,
            onPressed: () => provider.setLSClockData(title),
          ),
        ),
      ],
    );
  }
}

class DefaultClockPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          MaterialLocalizations.of(context).formatTimeOfDay(
            TimeOfDay.now(),
            alwaysUse24HourFormat: true,
          ),
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 6),
        ),
      );
}

class AnalogClockPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hourDiv = 2 * math.pi / 12;
    var minDiv = 2 * math.pi / 60;
    var hourNow = TimeOfDay.now().hour;
    var hour = hourNow > 12 ? hourNow - 12 : hourNow;
    var min = TimeOfDay.now().minute;
    return Center(
      child: Stack(
        children: <Widget>[
          Center(
            child: Builder(
              builder: (context) {
                double width = 20;
                double height = 3;
                return Transform.translate(
                  offset: Offset(width / 2, 0),
                  child: Transform.rotate(
                    angle:
                        (hourDiv * hour + (hourDiv * min / 60)) - (math.pi / 2),
                    origin: Offset(-width / 2, 0),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        borderRadius: BorderRadius.all(
                          Radius.circular(height / 2),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Builder(
              builder: (context) {
                double width = 36;
                double height = 2;
                return Transform.translate(
                  offset: Offset(width / 2, 0),
                  child: Transform.rotate(
                    angle: minDiv * min - (math.pi / 2),
                    origin: Offset(-width / 2, 0),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.6),
                        borderRadius: BorderRadius.all(
                          Radius.circular(height / 2),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: SizedBox(
              height: 6,
              width: 6,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BubbleClockPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hourDiv = 2 * math.pi / 12;
    var minDiv = 2 * math.pi / 60;
    var hourNow = TimeOfDay.now().hour;
    var hour = hourNow > 12 ? hourNow - 12 : hourNow;
    var min = TimeOfDay.now().minute;
    return Center(
      child: Stack(
        children: <Widget>[
          Center(
            child: Builder(
              builder: (context) {
                double width = 30;
                double height = 15;
                return Transform.translate(
                  offset: Offset(width / 2, 0),
                  child: Transform.rotate(
                    angle: minDiv * min - (math.pi / 2),
                    origin: Offset(-width / 2, 0),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.8),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(height / 2),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Builder(
              builder: (context) {
                double width = 15;
                double height = 15;
                return Transform.translate(
                  offset: Offset(width / 2, height),
                  child: Transform.rotate(
                    angle:
                        (hourDiv * hour + (hourDiv * min / 60)) - (math.pi / 2),
                    origin: Offset(-width / 2, 0),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
//                      color: Theme.of(context).textTheme.bodyText1.color,
                        border: Border.all(
                          width: 1.5,
                          color: Theme.of(context).accentColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(height / 2),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TypeClockPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hourNow = TimeOfDay.now().hour;
    var hour = hourNow >= 12 ? hourNow - 12 : hourNow;
    var min = TimeOfDay.now().minute;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            typeHeader,
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          Text(typeHour[hour]),
          Text(typeMinute[min]),
        ],
      ),
    );
  }
}

const typeHeader = "It's";
const List<String> typeHour = [
  "Twelve",
  "One",
  "Two",
  "Three",
  "Four",
  "Five",
  "Six",
  "Seven",
  "Eight",
  "Nine",
  "Ten",
  "Eleven",
];
const List<String> typeMinute = [
  "O' Clock",
  "Oh One",
  "Oh Two",
  "Oh Three",
  "Oh Four",
  "Oh Five",
  "Oh Six",
  "Oh Seven",
  "Oh Eight",
  "Oh Nine",
  "Ten",
  "Eleven",
  "Twelve",
  "Thirteen",
  "Fourteen",
  "Fifteen",
  "Sixteen",
  "Seventeen",
  "Eighteen",
  "Nineteen",
  "Twenty",
  "Twenty\nOne",
  "Twenty\nTwo",
  "Twenty\nThree",
  "Twenty\nFour",
  "Twenty\nFive",
  "Twenty\nSix",
  "Twenty\nSeven",
  "Twenty\nEight",
  "Twenty\nNine",
  "Thirty",
  "Thirty\nOne",
  "Thirty\nTwo",
  "Thirty\nThree",
  "Thirty\nFour",
  "Thirty\nFive",
  "Thirty\nSix",
  "Thirty\nSeven",
  "Thirty\nEight",
  "Thirty\nNine",
  "Forty",
  "Forty\nOne",
  "Forty\nTwo",
  "Forty\nThree",
  "Forty\nFour",
  "Forty\nFive",
  "Forty\nSix",
  "Forty\nSeven",
  "Forty\nEight",
  "Forty\nNine",
  "Fifty",
  "Fifty\nOne",
  "Fifty\nTwo",
  "Fifty\nThree",
  "Fifty\nFour",
  "Fifty\nFive",
  "Fifty\nSix",
  "Fifty\nSeven",
  "Fifty\nEight",
  "Fifty\nNine",
];
