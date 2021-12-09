import 'package:flutter/material.dart';
import 'package:potato_fries/backend/appinfo.dart';
import 'package:potato_fries/backend/extensions.dart';

class ThemeHeader extends StatelessWidget {
  const ThemeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppInfo appInfo = AppInfo.of(context);

    return appInfo.wallpaper != null
        ? DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(appInfo.wallpaper!),
                fit: BoxFit.cover,
              ),
            ),
            child: ColoredBox(
              color: context.theme.colorScheme.secondary.withOpacity(0.2),
            ),
          )
        : const SizedBox();
  }
}
