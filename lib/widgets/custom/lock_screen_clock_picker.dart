import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/provider/lock_screen.dart';
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
    var provider = Provider.of<PageProvider>(context) as LockScreenProvider;
    String curClock = provider.getLSClockData();
    return SizeableListTile(
      title: 'Lock Screen Clock',
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
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
                  SingleChildScrollView(
                    child: ClockOptions(provider),
                  ),
                ],
              ),
            );
          },
        );
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
  final LockScreenProvider provider;

  ClockOptions(this.provider);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Builder(
        builder: (context) {
          var provider = Provider.of<LockScreenProvider>(context);
          String curClock = provider.getLSClockData();
          var orientation = MediaQuery.of(context).orientation;
          return Wrap(
            spacing: orientation == Orientation.portrait ? 12.0 : 0,
            runSpacing: orientation == Orientation.portrait ? 8.0 : 0,
            alignment: WrapAlignment.center,
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
              ClockPreviewWrapper(
                child: DefaultBoldClockPreview(),
                title: lockClocks.keys.toList()[4],
                enabled: curClock == lockClocks.keys.toList()[4],
              ),
              ClockPreviewWrapper(
                child: SamsungClockPreview(),
                title: lockClocks.keys.toList()[5],
                enabled: curClock == lockClocks.keys.toList()[5],
              ),
              ClockPreviewWrapper(
                child: SamsungBoldClockPreview(),
                title: lockClocks.keys.toList()[6],
                enabled: curClock == lockClocks.keys.toList()[6],
              ),
              ClockPreviewWrapper(
                child: SfunyClockPreview(),
                title: lockClocks.keys.toList()[7],
                enabled: curClock == lockClocks.keys.toList()[7],
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
    var provider = Provider.of<LockScreenProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: Column(
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
                    ? TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor)
                    : null,
              ),
              backgroundColor: enabled ? Theme.of(context).accentColor : null,
              onPressed: () => provider.setLSClockData(title),
            ),
          ),
        ],
      ),
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

class DefaultBoldClockPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          MaterialLocalizations.of(context).formatTimeOfDay(
            TimeOfDay.now(),
            alwaysUse24HourFormat: true,
          ),
          style: TextStyle(
              fontWeight: FontWeight.bold,
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

class SamsungClockPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            MaterialLocalizations.of(context).formatHour(
              TimeOfDay.now(),
              alwaysUse24HourFormat: true,
            ),
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 6),
          ),
          Text(
            MaterialLocalizations.of(context).formatMinute(
              TimeOfDay.now(),
            ),
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 6),
          ),
        ],
      ),
    );
  }
}

class SamsungBoldClockPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            MaterialLocalizations.of(context).formatHour(
              TimeOfDay.now(),
              alwaysUse24HourFormat: true,
            ),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 6),
          ),
          Text(
            MaterialLocalizations.of(context).formatMinute(
              TimeOfDay.now(),
            ),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 6),
          ),
        ],
      ),
    );
  }
}

class SfunyClockPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            MaterialLocalizations.of(context).formatHour(
              TimeOfDay.now(),
              alwaysUse24HourFormat: true,
            ),
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 15),
          ),
          SizedBox(width: 2),
          Text(
            MaterialLocalizations.of(context).formatMinute(
              TimeOfDay.now(),
            ),
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 4),
          ),
        ],
      ),
    );
  }
}

