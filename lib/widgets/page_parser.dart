import 'package:flutter/material.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:provider/provider.dart';

class PageParser extends StatelessWidget {
  final String dataKey;
  final bool useTopPadding;

  PageParser({@required this.dataKey, this.useTopPadding = true});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: useTopPadding ? MediaQuery.of(context).padding.top : 8,
      ),
      shrinkWrap: true,
      itemCount: appData[dataKey].categories.length,
      itemBuilder: (context, cindex) {
        List<Widget> children = [];
        final _category = appData[dataKey].categories[cindex];
        final _categoryTitle = _category.title;
        final _prefs = _category.preferences;
        var provider = context.watch<PageProvider>();
        var appInfoProvider = context.watch<AppInfoProvider>();

        if (_prefs.isEmpty) return Container();

        children.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              _categoryTitle.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ),
        );

        List<Widget> gen = [];
        for (Preference _pref in _prefs) {
          bool enabled = true;
          bool skip = false;

          for (Dependency d in _pref.dependencies) {
            if (d is SettingDependency) {
              var sVal = provider.getValue(d.key);
              if (sVal != null) {
                enabled = enabled && (sVal == d.value);
              }
            } else if (d is PropDependency) {
              if (!appInfoProvider.isCompatCheckDisabled()) {
                var pVal = provider.getValue(d.key);
                if (d.value != pVal) skip = true;
              }
            }
          }

          if (!appInfoProvider.isVersionCheckDisabled() &&
              !_pref.versionConstraint
                  .isConstrained(appInfoProvider.hostVersion)) {
            skip = true;
          }

          if (skip) continue;

          gen.add(
            AnimatedOpacity(
              opacity: enabled ? 1.0 : 0.5,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: IgnorePointer(
                ignoring: !enabled,
                child: _pref.toWidget(context),
              ),
            ),
          );
        }

        if (gen.isEmpty) return Container();
        children.addAll(gen);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
      },
    );
  }
}
