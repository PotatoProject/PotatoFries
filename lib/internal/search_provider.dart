import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/base.dart';

///
/// Search providers
///
/// This file contains the base class that defines what a provider is and how it works
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
/// - The category of the provider, for example the location of the
///   setting modifier, like themes, lockscreen, qs and so on
/// - (o) The title of the item section ancestor, used for displaying it on search route
/// - (o) A provider, manages and updates the values of the item, can be used for switches and sliders
/// - (o) Extra data, literally, its used to pass some data that is unique or required for specific items
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
///     headerAncestor: "Colors",
///     provider: this.provider,
///     extraData: {
///       "variable": 2
///     }
///   )
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
  BaseDataProvider provider;
  Map<String, dynamic> extraData;

  SearchProvider({
    @required this.title,
    this.setting,
    this.type,
    this.inputType,
    this.description,
    this.icon,
    @required this.itemPosition,
    @required this.categoryIndex,
    this.headerAncestor,
    this.provider,
    this.extraData,
  });
}

enum SettingInputType { SLIDER, SWITCH }
