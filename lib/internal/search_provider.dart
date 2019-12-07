import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';

///
/// Search providers
///
/// This file contains definitions for search
/// results that should appear on search route.
/// Unfortunately for the time being these providers
/// are all hardcoded until we don't find a better way to generate them.
///
///
/// How to define a basic provider
///
/// Note: (s) before an item in the list means that the user can search for that
///       (o) before an item in the list means that the parameter is optional
/// 
/// A provider is made of 6 things basically:
/// - (s) The title of the provider (usually you wanna put in the listtile title)
/// - (s) (o) The provider description, like title it's usually the subtitle of the listtile, but it can be anything
/// - (o) ListTile icon to display on search results
/// - (o) The setting that the provider item modifies, this should be specified mostly with a switch settings tile
/// - (o) The setting type, whether global, secure or system
/// - (o) The input type, this param is subject to changes in the very near future, but it mostly defines if the
///   tile is a switch or slider one
/// - A special int value that indicates the position of the item in its listview
///   (unfortunately must be entered manually for now)
/// - And last but not least, the category of the provider, for example the location of the
///   setting modifier, like themes, lockscreen, qs and so on
///
/// Example:
///   SearchProvider(
///     title: "Example title",
///     setting: "random_setting_yeet",
///     type: SettingType.GLOBAL,
///     inputType: SettingInputType.SWITCH,
///     description: "Optional description, user can search for this",
///     icon: Icon(Icons.search),
///     itemPosition: 5, // this starts from 0
///     categoryIndex: 2, // this ranges from 0 to 5
///   )
///
///
/// Why can't we generate those?
/// 
/// At first glance i thought of adding the generator code on the ui elements,
/// but later figured out that those don't get layed out when you first run the app,
/// so the user would have to actually open every page for the providers to be added,
/// so this method seems better for now. Improvements are always welcome.
/// 

List<SearchProvider> searchItems = [];

class SearchProvider {
  String title;
  String setting;
  SettingType type;
  SettingInputType inputType;
  String description;
  Widget icon;
  int itemPosition;
  int categoryIndex;
  String headerAncestor;

  SearchProvider({
    @required String title,
    String setting,
    SettingType type,
    SettingInputType inputType,
    String description,
    Widget icon,
    @required int itemPosition,
    @required int categoryIndex,
    String headerAncestor,
  }) {
    this.title = title;
    this.setting = setting;
    this.type = type;
    this.inputType = inputType;
    this.description = description;
    this.icon = icon;
    this.itemPosition = itemPosition;
    this.categoryIndex = categoryIndex;
    this.headerAncestor = headerAncestor;
  }
}

enum SettingInputType {
  SLIDER,
  SWITCH
}