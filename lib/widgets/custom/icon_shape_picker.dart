import 'package:flutter/material.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:provider/provider.dart';

class IconShapePicker extends StatefulWidget {
//  final String title;
//  final String subtitle;
//  final String footer;
//  final Widget icon;
//  final bool enabled;
//  final Function setValue;
//  final Function getValue;
//
//  IconShapePicker({
//    @required this.title,
//    this.subtitle,
//    this.footer,
//    this.icon,
//    this.enabled = true,
//    @required this.setValue,
//    @required this.getValue,
//  })  : assert(title != null),
//        assert(setValue != null),
//        assert(getValue != null);

  @override
  _IconShapePickerState createState() => _IconShapePickerState();
}

class _IconShapePickerState extends State<IconShapePicker> {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<AppInfoProvider>(context);
    int curType = _provider.getIconShapeIndex();
    return SizeableListTile(
      title: 'Icon Shape',
      onTap: () {
//        var newVal = _provider.getIconShapeIndex() + 1;
//        _provider.setIconShape(newVal >= 4 ? 0 : newVal);
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Icon Shape',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: shapesPackageLabels.map((l) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => _provider.setIconShape(
                                    shapesPackageLabels.indexOf(l)),
                                child: ShapedIcon(
                                  iconSize: 56,
                                  type: shapesPackageLabels.indexOf(l),
                                  isOutline:
                                      curType != shapesPackageLabels.indexOf(l),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              );
            });
      },
      icon: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: shapesPackageLabels.map((t) {
          return AnimatedOpacity(
            opacity: shapesPackageLabels.indexOf(t) == curType ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: ShapedIcon(
              type: shapesPackageLabels.indexOf(t),
              isOutline: true,
            ),
          );
        }).toList(),
      ),
      subtitle: Text('Set system-wide icon shape'),
      trailing: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: shapesPackageLabels.map((t) {
          return AnimatedOpacity(
            opacity: shapesPackageLabels.indexOf(t) == curType ? 0.75 : 0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Text(t),
          );
        }).toList(),
      ),
    );
  }
}
