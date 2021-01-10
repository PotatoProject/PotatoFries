import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static const MethodChannel _channel = const MethodChannel('fries/utils');

  static Future<void> startActivity({String pkg, String cls}) async =>
      await _channel.invokeMethod('startActivity', {'pkg': pkg, 'cls': cls});

  static void showNavigationSheet({
    BuildContext context,
    List<BasePage> pages,
    Function(int index) onTap,
  }) {
    final provider = context.read<AppInfoProvider>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          pages.length,
          (index) => ListTile(
            leading: Icon(
              pages[index].icon,
              color: provider.pageIndex == index
                  ? Theme.of(context).accentColor
                  : Theme.of(context).iconTheme.color,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              pages[index].title,
              style: TextStyle(
                color: provider.pageIndex == index
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
              ),
            ),
            onTap: () {
              onTap(index);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  static void launchUrl(String url, {BuildContext context}) async {
    if (await canLaunch(url))
      await launch(url);
    else {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to open $url!'),
          ),
        );
      }
    }
  }
}
