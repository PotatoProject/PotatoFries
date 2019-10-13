import 'package:flutter/material.dart';

class OverlayList extends StatefulWidget {
  final String category;
  final Widget title;
  final Widget icon;
  final bool enabled;

  OverlayList({
    @required this.category,
    @required this.title,
    this.icon,
    this.enabled = true,
  })  : assert(category != null),
        assert(title != null);

  @override
  createState() => _OverlayListState();
}

class _OverlayListState extends State<OverlayList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tmp(),
      initialData: "",
      builder: (context, snapshot) {
        String text = snapshot.data;

        return ListTile(
          leading: Container(width: 40, child: widget.icon),
          title: widget.title,
          trailing: Text(text),
          onTap: () async {
            dynamic result = await showDialog(
                context: context,
                builder: (context) {
                  return OverlayListDialog(
                    title: widget.title,
                  );
                });

            if (result != null) setState(() => text = result);
          },
        );
      },
    );
  }

  // TODO: Replace with native call
  Future<String> _tmp() async => "Cool overlay";
}

class OverlayListDialog extends StatefulWidget {
  final Widget title;

  OverlayListDialog({
    @required this.title,
  }) : assert(title != null);

  @override
  createState() => _OverlayListDialogState();
}

class _OverlayListDialogState extends State<OverlayListDialog> {
  String selectedOverlay = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tmp(),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          selectedOverlay = snapshot.data[0].package;
        }

        return AlertDialog(
          title: widget.title,
          content: Container(
            height: 60.0 * snapshot.data.length,
            width: 200,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: snapshot.data[index].package,
                  groupValue: selectedOverlay,
                  title: Text(snapshot.data[index].name),
                  onChanged: (overlay) =>
                      Navigator.pop(context, snapshot.data[index].name),
                );
              },
              itemCount: snapshot.data.length,
            ),
          ),
        );
      },
    );
  }

  // TODO: Replace with native call
  Future<List<OverlayInfo>> _tmp() async => [
        OverlayInfo(
          name: "Cool overlay",
          package: "android.cool_overlay",
        ),
        OverlayInfo(
          name: "Another cool overlay",
          package: "android.another_cool_overlay",
        ),
      ];
}

class OverlayInfo {
  String package;
  String name;

  OverlayInfo({this.package, this.name});
}
