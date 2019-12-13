import 'package:flutter/material.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/ui/accent_preview.dart';
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

  double lightHue = 0, darkHue = 0;
  double lightSaturation = 0, darkSaturation = 0;
  double lightLightness = 0, darkLightness = 0;

  SelectedColor selectedColor = SelectedColor.LIGHT;

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
            lightHue = l.hue;
            darkHue = d.hue;
            lightSaturation = l.saturation;
            darkSaturation = d.saturation;
            lightLightness = l.lightness;
            darkLightness = d.lightness;
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
                          color: Theme.of(context).bottomSheetTheme.backgroundColor,
                        ),
                        onPressed: () {
                          String dark = HSLColor.fromAHSL(
                            1,
                            darkHue,
                            darkSaturation,
                            darkLightness,
                          ).toColor().value.toRadixString(16).substring(2, 8);
                          String light = HSLColor.fromAHSL(
                            1,
                            lightHue,
                            lightSaturation,
                            lightLightness,
                          ).toColor().value.toRadixString(16).substring(2, 8);
                          widget.onApply(dark, light);
                          Navigator.of(context).pop();
                        },
                        backgroundColor: Theme.of(context).accentColor,
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
                      AccentPreview(
                        color: HSLColor.fromAHSL(1, lightHue, lightSaturation, lightLightness),
                        title: 'Light',
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        selected: selectedColor == SelectedColor.LIGHT,
                        onTap: () => setState(() => selectedColor = SelectedColor.LIGHT),
                        onDialogComplete: (color) {
                          HSLColor light = HSLColor.fromColor(color);
                          lightHue = light.hue;
                          lightSaturation = light.saturation;
                          lightLightness = light.lightness;
                          setState(() {});
                        },
                      ),
                      AccentPreview(
                        color: HSLColor.fromAHSL(1, darkHue, darkSaturation, darkLightness),
                        title: 'Dark',
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        selected: selectedColor == SelectedColor.DARK,
                        isDark: true,
                        onTap: () => setState(() => selectedColor = SelectedColor.DARK),
                        onDialogComplete: (color) {
                          HSLColor dark = HSLColor.fromColor(color);
                          darkHue = dark.hue;
                          darkSaturation = dark.saturation;
                          darkLightness = dark.lightness;
                          setState(() {});
                        },
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
                      activeColor: Theme.of(context).accentColor,
                      inactiveColor: Theme.of(context).accentColor.withAlpha(120),
                      value: selectedColor == SelectedColor.LIGHT ? lightHue : darkHue,
                      min: 0,
                      max: 360,
                      onChanged: (d) => setState(() => selectedColor == SelectedColor.LIGHT ?
                          lightHue = d :
                          darkHue = d),
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
                      activeColor: Theme.of(context).accentColor,
                      inactiveColor: Theme.of(context).accentColor.withAlpha(120),
                      value: selectedColor == SelectedColor.LIGHT ? lightSaturation : darkSaturation,
                      min: 0,
                      max: 1,
                      onChanged: (d) => setState(() => selectedColor == SelectedColor.LIGHT ?
                          lightSaturation = d :
                          darkSaturation = d),
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
                        activeColor: Theme.of(context).accentColor,
                        inactiveColor: Theme.of(context).accentColor.withAlpha(120),
                        value: selectedColor == SelectedColor.LIGHT ? lightLightness : darkLightness,
                        min: selectedColor == SelectedColor.LIGHT ? 0 : 0.5,
                        max: selectedColor == SelectedColor.LIGHT ? 0.5 : 1,
                        onChanged: (d) => setState(() => selectedColor == SelectedColor.LIGHT ?
                            lightLightness = d :
                            darkLightness = d),
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
                      String lightHSL =
                          [lightHue.toString(), lightSaturation.toString(), lightLightness.toString()].join(":");
                      
                      String darkHSL =
                          [darkHue.toString(), darkSaturation.toString(), darkLightness.toString()].join(":");
                      
                      String readyString = [lightHSL, darkHSL].join("|");

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
                    List<String> fetchedLightHSL = fetchedString.split("|")[0].split(":");
                    List<String> fetchedDarkHSL = fetchedString.split("|")[1].split(":");
                    List<double> lightHSL = List.generate(fetchedLightHSL.length, (i) {
                      return double.parse(fetchedLightHSL[i]);
                    });
                    List<double> darkHSL = List.generate(fetchedDarkHSL.length, (i) {
                      return double.parse(fetchedDarkHSL[i]);
                    });

                    return FadeTransition(
                      opacity: enterAnim,
                      child: FavColorTile(
                        light: HSLColor.fromAHSL(1, lightHSL[0], lightHSL[1], lightHSL[2]),
                        dark: HSLColor.fromAHSL(1, darkHSL[0], darkHSL[1], darkHSL[2]),
                        onTap: (light, dark) {
                          lightHue = light.hue;
                          lightSaturation = light.saturation;
                          lightLightness = light.lightness;
                          darkHue = dark.hue;
                          darkSaturation = dark.saturation;
                          darkLightness = dark.lightness;
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
                                light: HSLColor.fromAHSL(1, lightHSL[0], lightHSL[1], lightHSL[2]),
                                dark: HSLColor.fromAHSL(1, darkHSL[0], darkHSL[1], darkHSL[2]),
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
}

enum SelectedColor { LIGHT, DARK }