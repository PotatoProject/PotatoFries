import 'package:flutter/material.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/routes/search_route.dart';
import 'package:potato_fries/ui/croquette_badge.dart';

class FriesPage extends StatelessWidget {
  final String title;
  final Widget header;
  final List<Widget> children;
  final bool showActions;

  FriesPage({
    @required this.children,
    @required this.title,
    this.header,
    this.showActions = true,
  })  : assert(children != null),
        assert(title != null);

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CroquetteBadge(),
                SizedBox(height: 10.0),
                Text("BUILD INFO HERE"),
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("CLOSE"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      children: <Widget>[
        AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(title),
          actions: showActions
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchRoute())),
                  ),
                  PopupMenuButton(
                    elevation: 3,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 0,
                          child: ListTile(
                            leading: Icon(Icons.system_update),
                            title: Text("PotatoCenter"),
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Discover POSP team"),
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Build info"),
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      switch (value) {
                        case 0:
                          break;
                        case 1:
                          launchUrl("https://potatoproject.co/team");
                          break;
                        case 2:
                          _showDialog();
                          break;
                      }
                    },
                  ),
                ]
              : null,
        ),
        Container(child: header),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Container(
              child: ListView(children: children),
            ),
          ),
        ),
      ],
    );
  }
}
