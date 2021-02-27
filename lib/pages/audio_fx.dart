import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/audio_fx.dart';
import 'package:potato_fries/widgets/settings_dropdown.dart';
import 'package:provider/provider.dart';

class AudioFx extends BasePage {
  @override
  String get title => LocaleStrings.audiofx.title;

  @override
  IconData get icon => Icons.audiotrack;

  @override
  String get providerKey => "audiofx";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AudioFxProvider>.value(
      value: AudioFxProvider(),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
          bottom: 8,
        ),
        child: Builder(
          builder: (context) {
            final provider = context.watch<AudioFxProvider>();

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Builder(
                    builder: (context) {
                      List<Point> data = [];
                      for (int i = 0; i < provider.bands.length; i++) {
                        data.add(Point(i, provider.bands[i] ?? 0));
                      }
                      return AbsorbPointer(
                        absorbing: !provider.enabled,
                        child: AnimatedOpacity(
                          opacity: provider.enabled ? 1.0 : 0.3,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: CoolGraphCard(
                            data: data,
                            min: -10,
                            max: 10,
                            color: provider.profileColor ??
                                Theme.of(context).accentColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: provider.enabled
                        ? (provider.profileColor ??
                            Theme.of(context).accentColor)
                        : HSLColor.fromColor(Color(0xffffffff))
                            .withLightness(0.3)
                            .toColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            provider.enabled
                                ? LocaleStrings.audiofx.statusOn
                                : LocaleStrings.audiofx.statusOff,
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer(),
                          Switch(
                            onChanged: (v) => provider.enabled = v,
                            value: provider.enabled,
                            activeColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AbsorbPointer(
                  absorbing: !provider.enabled,
                  child: AnimatedOpacity(
                    opacity: provider.enabled ? 1.0 : 0.3,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: DropdownTile(
                      title: LocaleStrings.audiofx.audioPresetTitle,
                      values: Map<String, String>.from(provider.profileMap),
                      value: provider.profile,
                      onValueChanged: (v) => provider.setProfile(v),
                      selectedColor: provider.profileColor ??
                          Theme.of(context).accentColor,
                      icon: Icon(Icons.equalizer),
                    ),
                  ),
                ),
                AbsorbPointer(
                  absorbing: !provider.enabled,
                  child: AnimatedOpacity(
                    opacity: provider.enabled ? 1.0 : 0.3,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: DropdownTile(
                      title: LocaleStrings.audiofx.headsetProfileTitle,
                      values: Map.fromIterable(
                        provider.headphones,
                        key: (v) => v,
                        value: (v) => v,
                      ),
                      value: provider.headphones[provider.headset] ??
                          LocaleStrings.audiofx.headsetProfileDefault,
                      onValueChanged: (v) => provider.headset =
                          (provider.headphones.indexOf(v) ?? 0),
                      selectedColor: provider.profileColor ??
                          Theme.of(context).accentColor,
                      icon: Icon(Icons.headset),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AbsorbPointer(
                    absorbing: !provider.enabled,
                    child: AnimatedOpacity(
                      opacity: provider.enabled ? 1.0 : 0.3,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: AudioFxSliders(),
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AudioFxSliders extends StatelessWidget {
  final List<String> labels = new List.from([
    "65Hz",
    "160Hz",
    "400Hz",
    "1KHz",
    "2.5KHz",
    "6KHz",
    "14KHz",
  ]);

  List<Widget> getSliders(AudioFxProvider provider, BuildContext context) {
    List<Widget> ret = [];
    for (int i = 0; i < (provider.bands.length ?? 7); i++) {
      ret.add(
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FlutterSlider(
                  values: [provider.bands[i] ?? 0],
                  max: 10,
                  min: -10,
                  axis: Axis.vertical,
                  rtl: true,
                  centeredOrigin: true,
                  handler: FlutterSliderHandler(
                    child: Icon(
                      Icons.drag_handle,
                      color: provider.profileColor ??
                          Theme.of(context).accentColor,
                      size: 24,
                    ),
                  ),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(
                      color: provider.profileColor ??
                          Theme.of(context).accentColor,
                    ),
                    inactiveTrackBar: BoxDecoration(
                      color: (provider.profileColor ??
                              Theme.of(context).accentColor)
                          .withOpacity(0.25),
                    ),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    provider.setBand(i, lowerValue);
                  },
                ),
              ),
              SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Opacity(opacity: 0.35, child: Text(labels[i])),
              ),
            ],
          ),
        ),
      );
    }
    ret.add(
      Expanded(
        child: Column(
          children: <Widget>[
            SizedBox(height: 32),
            Opacity(opacity: 0.35, child: Text('-10 db')),
            Spacer(),
            Opacity(opacity: 0.35, child: Text('+10 db')),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
    return ret;
  }

  @override
  Widget build(BuildContext context) => Row(
        children: getSliders(context.watch<AudioFxProvider>(), context),
      );
}

class CoolGraphCard extends StatelessWidget {
  final List<Point> data;
  final double max;
  final double min;
  final Color color;

  CoolGraphCard({
    this.data,
    this.min,
    this.max,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.1)
              : null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            child: CoolGraph(
              data: data,
              min: min,
              max: max,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class CoolGraph extends StatelessWidget {
  final List<Point> data;
  final double max;
  final double min;

  final Color color;

  CoolGraph({
    this.data,
    this.min,
    this.max,
    this.color,
  });

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: Size.infinite,
        painter: _GraphPainter(
          context: context,
          dataPoints: data,
          min: min,
          max: max,
          color: color,
        ),
      );
}

class _GraphPainter extends CustomPainter {
  _GraphPainter({
    this.context,
    this.dataPoints,
    this.color = Colors.red,
    this.min,
    this.max,
  });

  final List<Point> dataPoints;
  final BuildContext context;
  final Color color;
  final double max;
  final double min;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..strokeWidth = 2.0
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final path = Path();
    final fillPath = Path();

    Paint fillPaint = new Paint()
      ..strokeWidth = 0.0
      ..style = PaintingStyle.fill;

    Point min = Point((double.maxFinite), (double.maxFinite));
    Point max = Point((-double.maxFinite), (-double.maxFinite));
    List<double> differencesX = [];
    List<double> differencesY = [];
    double avgX = 0;
    double avgY = 0;
    for (int i = 0; i < dataPoints.length; i++) {
      if (i != 0) {
        differencesX.add((dataPoints[i].x - dataPoints[i - 1].x).toDouble());
        differencesY.add((dataPoints[i].y - dataPoints[i - 1].y).toDouble());
      }
      if (dataPoints[i].x < min.x) min = Point(dataPoints[i].x, min.y);
      if (dataPoints[i].y < min.y) min = Point(min.x, dataPoints[i].y);
      if (dataPoints[i].x > max.x) max = Point(dataPoints[i].x, max.y);
      if (dataPoints[i].y > max.y) max = Point(max.x, dataPoints[i].y);
    }

    if (this.max != null && this.min != null) {
      min = Point(min.x, this.min);
      max = Point(max.x, this.max);
    }
    differencesX.forEach((v) => avgX += v);
    differencesY.forEach((v) => avgY += v);
    avgX = (avgX / differencesX.length).floorToDouble();
    avgX = avgX == 0 ? 1 : avgX;
    avgY = (avgY / differencesY.length).floorToDouble();
    avgY = avgY == 0 ? 1 : avgY;

    // Normalize data points
    List<Point> normalizedPoints = [];
    for (int i = 0; i < dataPoints.length; i++) {
      if (max.y != min.y)
        normalizedPoints
            .add(Point(dataPoints[i].x - min.x, dataPoints[i].y - min.y));
      else
        normalizedPoints.add(Point(dataPoints[i].x, dataPoints[i].y));
    }
    double sizeIntervalX = ((max.x - min.x) / avgX) == 0
        ? size.width / 2
        : size.width / ((max.x - min.x) / avgX);
    double sizeIntervalY = ((max.y - min.y) / avgY) == 0
        ? size.height / 2
        : size.height / ((max.y - min.y) / avgY);

    Point lastPoint;
    List<Offset> circles = [];

    for (int i = 0; i < dataPoints.length; i++) {
      double posX = (normalizedPoints[i].x * sizeIntervalX) / avgX;
      double posY =
          size.height - ((normalizedPoints[i].y * sizeIntervalY) / avgY);

      if (lastPoint == null) {
        lastPoint = Point(posX, posY);
      }

      final Point p1 =
          Point(lastPoint.x + (posX - lastPoint.x) / 2, lastPoint.y);
      final Point p2 = Point(lastPoint.x + (posX - lastPoint.x) / 2, posY);

      if (i == 0) {
        path.moveTo(posX, posY);
        fillPath.moveTo(posX, posY);
      } else {
        path.cubicTo(p1.x, p1.y, p2.x, p2.y, posX, posY);
        fillPath.cubicTo(p1.x, p1.y, p2.x, p2.y, posX, posY);
      }
      circles.add(Offset(posX, posY));
      lastPoint = Point(posX, posY);
    }
    fillPath.lineTo(lastPoint.x, size.height);
    fillPath.lineTo(0, size.height);
    final Rect fillRect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    fillPaint.shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.75),
          color.withOpacity(0.3),
          color.withOpacity(0),
        ]).createShader(fillRect);
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_GraphPainter oldDelegate) {
    return oldDelegate.dataPoints != this.dataPoints ||
        oldDelegate.color != this.color;
  }
}
