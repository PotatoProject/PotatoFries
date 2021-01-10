import 'package:flutter/material.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:url_launcher/url_launcher.dart';

void showNavigationSheet({
  BuildContext context,
  AppInfoProvider provider,
  List<BasePage> items,
  Function(int index) onTap,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        items.length,
        (index) => ListTile(
          leading: Icon(
            items[index].icon,
            color: provider.pageIndex == index
                ? Theme.of(context).accentColor
                : Theme.of(context).iconTheme.color,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 24),
          title: Text(
            items[index].title,
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

void launchUrl(String url, {BuildContext context}) async {
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
