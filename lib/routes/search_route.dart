import 'package:flutter/material.dart';
import 'package:potato_fries/internal/search_provider.dart';
import 'package:potato_fries/widgets/search_provider_item.dart';

class SearchRoute extends StatefulWidget {
  @override
  createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  String searchTerms = "";
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    widgets = providerSearchList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextField(
          onChanged: (text) {
            setState(() {
              searchTerms = text;
              widgets = providerSearchList(context);
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search...",
          ),
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ),
      body: ListView(
        children: widgets,
      ),
    );
  }

  List<Widget> providerSearchList(BuildContext context) {
    List<SearchProvider> providerList = [];
    List<Widget> widgetList = [];

    if(searchTerms != "") {
      for (int i = 0; i < searchItems.length; i++) {
        List<String> title = searchItems[i].title.toLowerCase().split(" ");
        List<String> description = searchItems[i].description?.toLowerCase()?.split(" ") ?? [];
        String query = searchTerms.toLowerCase();

        bool addToList = title.any((item) => item.startsWith(query)) ||
            description.any((item) => item.startsWith(query));

        if (addToList) {
          providerList.add(searchItems[i]);
        }
      }

      for (int i = 0; i < providerList.length; i++) {
        widgetList.add(SearchProviderItem(provider: providerList[i]));
      }

      return widgetList;
    } else return [Container()];
  }
}