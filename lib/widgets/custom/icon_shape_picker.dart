import 'package:flutter/material.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:provider/provider.dart';

class IconShapePicker extends StatelessWidget {
  Widget build(BuildContext context) {
    var _provider = Provider.of<AppInfoProvider>(context);
    MapEntry<String, String> curType = _provider.getIconShape();
    final shapes = _provider.shapes;

    return SizeableListTile(
      title: 'Icon Shape',
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 24,
                    bottom: 24,
                  ),
                  child: Text(
                    'System icon Shape',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final MapEntry shapeInfo = MapEntry(
                      shapes.keys.toList()[index],
                      shapes.values.toList()[index],
                    );

                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _provider.setIconShape(index);
                        },
                        child: ShapedIcon(
                          iconSize: 56,
                          pathData: shapeInfo.value,
                          isOutline: curType.key != shapeInfo.key,
                        ),
                      ),
                    );
                  },
                  itemCount: shapes.length,
                  shrinkWrap: true,
                ),
              ],
            );
          },
        );
      },
      icon: ShapedIcon.currentShape(
        isOutline: true,
      ),
      subtitle: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: Text(_provider.getShapeLabel()),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }
}
