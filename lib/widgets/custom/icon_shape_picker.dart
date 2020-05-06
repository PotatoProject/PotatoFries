import 'package:flutter/material.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:provider/provider.dart';

class IconShapePicker extends StatefulWidget {

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
                        'System icon Shape',
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
                                onTap: () {
                                  Navigator.pop(context);
                                  _provider.setIconShape(
                                    shapesPackageLabels.indexOf(l));
                                },
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
      subtitle: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: shapesPackageLabels.map((t) {
          return AnimatedOpacity(
            opacity: shapesPackageLabels.indexOf(t) == curType ? 1 : 0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Text(t),
          );
        }).toList(),
      ),
    );
  }
}
