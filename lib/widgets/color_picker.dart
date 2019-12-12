import 'package:flutter/material.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/ui/fav_color_tile.dart';

class ColorPicker extends StatefulWidget {
  final bool lightnessLocked;
  final Function onApply;
  final Function onChange;
  final String title;
  final double lightnessMin;
  final double lightnessMax;
  final double lightnessDeltaCenter;
  final double lightnessDeltaEnd;

  final Color defaultDark;
  final Color defaultLight;
  final Color defaultColor;

  ColorPicker({
    this.lightnessLocked = false,
    this.onApply,
    this.title = 'Color picker',
    this.onChange,
    this.lightnessMin = 0,
    this.lightnessMax = 1,
    this.lightnessDeltaCenter = 0,
    this.lightnessDeltaEnd = 0,
    this.defaultDark,
    this.defaultLight,
    this.defaultColor,
  })  : assert(lightnessDeltaCenter + lightnessDeltaEnd <= 1),
        assert(!lightnessLocked &&
            (lightnessDeltaCenter != 0 || lightnessDeltaEnd != 0));

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double hue = 0;
  double saturation = 0.5;
  double lightness = 0.5;
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(
        () {
          if (widget.defaultColor != null) {
            var c = HSLColor.fromColor(widget.defaultColor);
            hue = c.hue;
            saturation = c.saturation;
            lightness = c.lightness;
          } else {
            var d = HSLColor.fromColor(widget.defaultDark ?? Colors.white);
            var l = HSLColor.fromColor(widget.defaultLight ?? Colors.black);
            hue = d.hue;
            saturation = d.saturation;
            lightness = (d.lightness + l.lightness) / 2;
          }
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    lightness = widget.lightnessLocked ? 0.5 : lightness;
    double lightnessLight = lightness;
    double lightnessDark = lightness;
    double lightnessNeutral = lightness;
    if (widget.lightnessDeltaEnd != 0 || widget.lightnessDeltaCenter != 0) {
      lightnessNeutral = 0.5;
      double absolute =
          (1 - widget.lightnessDeltaEnd - widget.lightnessDeltaCenter) *
              lightness /
              2;
      lightnessDark = (0.5 + widget.lightnessDeltaCenter / 2) + absolute;
      lightnessLight = (0.5 - widget.lightnessDeltaCenter / 2) - absolute;
    }
    if (widget.onChange != null)
      widget.onChange(
        HSLColor.fromAHSL(1, hue, saturation, lightnessDark).toColor(),
        HSLColor.fromAHSL(1, hue, saturation, lightnessLight).toColor(),
        ctx: context,
      );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Visibility(
                      visible: widget.onApply != null,
                      child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        child: Icon(
                          Icons.check,
                          color:
                              HSLColor.fromAHSL(1, hue, saturation, 0.85).toColor(),
                        ),
                        onPressed: () {
                          String dark = HSLColor.fromAHSL(
                            1,
                            hue,
                            saturation,
                            lightnessDark,
                          ).toColor().value.toRadixString(16).substring(2, 8);
                          String light = HSLColor.fromAHSL(
                            1,
                            hue,
                            saturation,
                            lightnessLight,
                          ).toColor().value.toRadixString(16).substring(2, 8);
                          widget.onApply(dark, light);
                          Navigator.of(context).pop();
                        },
                        backgroundColor:
                            HSLColor.fromAHSL(1, hue, saturation, 0.5).toColor(),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.lightnessLocked ||
                    (widget.lightnessDeltaEnd == 0 &&
                        widget.lightnessDeltaCenter == 0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 12,
                  decoration: BoxDecoration(
                    color: HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                        .toColor(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '#' +
                          HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                              .toColor()
                              .value
                              .toRadixString(16)
                              .substring(2, 8),
                      style: TextStyle(
                        color: lightnessNeutral > 0.5
                            ? Colors.black.withOpacity(0.70)
                            : Colors.white.withOpacity(0.70),
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.lightnessDeltaEnd != 0 ||
                    widget.lightnessDeltaCenter != 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      accentPreview(
                        lightnessLight,
                        'Light',
                        BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      accentPreview(
                        lightnessDark,
                        'Dark',
                        BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Text('Hue'),
                  Spacer(),
                  Container(
                    width: (MediaQuery.of(context).size.width / 10) * 7,
                    child: Slider(
                      activeColor:
                          HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                              .toColor(),
                      inactiveColor:
                          HSLColor.fromAHSL(0.25, hue, saturation, lightnessNeutral)
                              .toColor(),
                      value: hue,
                      min: 0,
                      max: 360,
                      onChanged: (d) => setState(() => hue = d),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Saturation'),
                  Spacer(),
                  Container(
                    width: (MediaQuery.of(context).size.width / 10) * 7,
                    child: Slider(
                      activeColor:
                          HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                              .toColor(),
                      inactiveColor:
                          HSLColor.fromAHSL(0.25, hue, saturation, lightnessNeutral)
                              .toColor(),
                      value: saturation,
                      min: 0,
                      max: 1,
                      onChanged: (d) => setState(() => saturation = d),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: !widget.lightnessLocked,
                child: Row(
                  children: <Widget>[
                    Text('Lightness'),
                    Spacer(),
                    Container(
                      width: (MediaQuery.of(context).size.width / 10) * 7,
                      child: Slider(
                        activeColor:
                            HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                                .toColor(),
                        inactiveColor: HSLColor.fromAHSL(
                                0.25, hue, saturation, lightnessNeutral)
                            .toColor(),
                        value: lightness,
                        min: widget.lightnessMin,
                        max: widget.lightnessMax,
                        onChanged: (d) => setState(() => lightness = d),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        SizedBox(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox.fromSize(
                  size: Size.square(48),
                  child: InkWell(
                    onTap: () {
                      String stringHSL =
                          [hue.toString(), saturation.toString(), lightness.toString()].join(":");
                      
                      String stringLightnesses =
                          [lightnessLight.toString(), lightnessDark.toString()].join(":");
                      
                      String readyString = [stringHSL, stringLightnesses].join("|");

                      appInfo.savedColors = List.from(appInfo.savedColors)..add(readyString);
                      
                      listKey.currentState.insertItem(0);
                    },
                    borderRadius: BorderRadius.circular(48),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        border: Border.all(
                          color: Theme.of(context).textTheme.subtitle.color.withAlpha(80),
                          width: 2,
                        )
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).textTheme.subtitle.color.withAlpha(80),
                        ),
                      ),
                    ),
                  )
                )
              ),
              VerticalDivider(
                indent: 8,
                endIndent: 8,
                width: 1,
              ),
              Expanded(
                child: AnimatedList(
                  key: listKey,
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  initialItemCount: appInfo.savedColors.length,
                  itemBuilder: (context, index, enterAnim) {

                    List<String> reverseColors = appInfo.savedColors.reversed.toList();

                    String fetchedString = reverseColors[index];
                    List<String> fetchedStringHSL = fetchedString.split("|")[0].split(":");
                    List<String> fetchedStringLightnesses = fetchedString.split("|")[1].split(":");
                    List<double> baseHSL = List.generate(fetchedStringHSL.length, (i) {
                      return double.parse(fetchedStringHSL[i]);
                    });
                    List<double> lightnessLightDark = List.generate(fetchedStringLightnesses.length, (i) {
                      return double.parse(fetchedStringLightnesses[i]);
                    });

                    return FadeTransition(
                      opacity: enterAnim,
                      child: FavColorTile(
                        base: HSLColor.fromAHSL(1, baseHSL[0], baseHSL[1], baseHSL[2]),
                        lightLightness: lightnessLightDark[0],
                        darkLightness: lightnessLightDark[1],
                        onTap: (base, light, dark) {
                          hue = base.hue;
                          saturation = base.saturation;
                          lightness = base.lightness;
                          lightnessLight = light;
                          lightnessDark = dark;
                          setState(() {});
                        },
                        onDelete: () {
                          reverseColors.removeAt(index);
                          List<String> originalList = reverseColors.reversed.toList();
                          appInfo.savedColors = List.from(originalList);
                          listKey.currentState.removeItem(index, (context, removeAnim) {
                            return FadeTransition(
                              opacity: removeAnim,
                              child: FavColorTile(
                                base: HSLColor.fromAHSL(1, baseHSL[0], baseHSL[1], baseHSL[2]),
                                lightLightness: lightnessLightDark[0],
                                darkLightness: lightnessLightDark[1],
                              ),
                            );
                          }, duration: Duration(milliseconds: 200));
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          height: 64,
        )
      ],
    );
  }

  Widget accentPreview(
    double lightness,
    String title,
    BorderRadius borderRadius,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: HSLColor.fromAHSL(1, hue, saturation, lightness).toColor(),
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(
                '#' +
                    HSLColor.fromAHSL(1, hue, saturation, lightness)
                        .toColor()
                        .value
                        .toRadixString(16)
                        .substring(2, 8),
                style: TextStyle(
                  color: lightness > 0.5
                      ? Colors.black.withOpacity(0.70)
                      : Colors.white.withOpacity(0.70),
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: lightness > 0.5
                          ? Colors.black.withOpacity(0.40)
                          : Colors.white.withOpacity(0.40),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
