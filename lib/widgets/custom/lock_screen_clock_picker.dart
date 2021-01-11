import 'dart:math' as math;

import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:provider/provider.dart';

final SettingKey _lsClockKey = SettingKey<String>(
  "lock_screen_custom_clock_face",
  SettingType.SECURE,
);

class LockScreenClockPicker extends StatefulWidget {
  @override
  _LockScreenClockPickerState createState() => _LockScreenClockPickerState();
}

class _LockScreenClockPickerState extends State<LockScreenClockPicker> {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<PageProvider>();
    final curClock = provider.getLsClockPackage();

    return SizeableListTile(
      title: LocaleStrings.lockscreen.clocksLockScreenClockTitle,
      onTap: () {
        Utils.showBottomSheet(
          context: context,
          builder: (context) {
            return IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 24,
                      bottom: 32,
                    ),
                    child: Text(
                      LocaleStrings.lockscreen.clocksLockScreenClockTitle,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ClockOptions(provider),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: Icon(
        MdiIcons.lockClock,
        color: Theme.of(context).iconTheme.color,
      ),
      subtitle: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeOut,
        child: Text(
          provider.getLsClockLabel(),
          key: ValueKey(curClock),
        ),
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
            alignment: AlignmentDirectional.centerStart,
          );
        },
      ),
    );
  }
}

class ClockOptions extends StatelessWidget {
  final PageProvider provider;

  ClockOptions(this.provider);

  static final List<Widget> _previews = [
    DefaultClockPreview(),
    BubbleClockPreview(),
    AnalogClockPreview(),
    TypeClockPreview(),
    DefaultBoldClockPreview(),
    SamsungClockPreview(),
    SamsungBoldClockPreview(),
    SfunyClockPreview(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PageProvider>();
    final curClock = provider.getValue(_lsClockKey);

    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: List.generate(
        lockClocks.length,
        (index) => ClockPreviewWrapper(
          child: _previews[index],
          title: lockClocks.values.toList()[index],
          value: lockClocks.keys.toList()[index],
          enabled: curClock == lockClocks.keys.toList()[index],
        ),
      ),
    );
  }
}

class ClockPreviewWrapper extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final String title;
  final String value;

  ClockPreviewWrapper(
      {this.title, this.value, this.child, this.enabled = false});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<PageProvider>();
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => provider.setValue(_lsClockKey, value),
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
              onPressed: () => provider.setLsClockPackage(value),
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
