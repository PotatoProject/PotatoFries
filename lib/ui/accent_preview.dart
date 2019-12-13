import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccentPreview extends StatelessWidget {
  final HSLColor color;
  final String title;
  final BorderRadius borderRadius;
  final void Function() onTap;
  final void Function(Color) onDialogComplete;
  final isDark;

  AccentPreview({
    @required this.color,
    @required this.title,
    @required this.borderRadius,
    this.onTap,
    this.onDialogComplete,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: HSLColor.fromAHSL(1, color.hue, color.saturation, color.lightness).toColor(),
          borderRadius: borderRadius,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            onLongPress: () async {
              var result = await showDialog(
                context: context,
                builder: (context) => AccentPreviewHexPicker(
                  color: HSLColor.fromAHSL(1, color.hue, color.saturation, color.lightness),
                  isDarkPicker: isDark,
                ),
              );

              if(onDialogComplete != null && result != null)
                  onDialogComplete(result);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '#' +
                    HSLColor.fromAHSL(1, color.hue, color.saturation, color.lightness)
                        .toColor()
                        .value
                        .toRadixString(16)
                        .substring(2, 8),
                  style: TextStyle(
                    color: color.lightness > 0.5
                        ? Colors.black.withOpacity(0.70)
                        : Colors.white.withOpacity(0.70),
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: color.lightness > 0.5
                        ? Colors.black.withOpacity(0.40)
                        : Colors.white.withOpacity(0.40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccentPreviewHexPicker extends StatefulWidget {
  final HSLColor color;
  final bool isDarkPicker;

  AccentPreviewHexPicker({
    @required this.color,
    this.isDarkPicker = false,
  });

  @override
  _AccentPreviewHexPickerState createState() => _AccentPreviewHexPickerState();
}

class _AccentPreviewHexPickerState extends State<AccentPreviewHexPicker> {
  TextEditingController controller;
  FocusNode node = FocusNode();
  bool error = false;
  String errorMessage = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String hexColor = widget.color.toColor()
          .value
          .toRadixString(16)
          .substring(2, 8);
      
      controller = TextEditingController(text: hexColor);
      controller.selection = TextSelection.collapsed(offset: 6);
      FocusScope.of(context).requestFocus(node);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Hex input"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("#"),
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: node,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6)
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Visibility(
              visible: error,
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
          textColor: Theme.of(context).accentColor,
        ),
        FlatButton(
          child: Text("Confirm"),
          onPressed: () {
            if(controller.text.length == 6 && RegExp("^[0-9A-Fa-f]+\$").hasMatch(controller.text)) {
              Color textColor = Color(int.parse(controller.text, radix: 16));

              if(textColor.computeLuminance() > 0.5) {
                if(!widget.isDarkPicker) {
                  setState(() {
                    error = true;
                    errorMessage = "Color is too bright";
                  });
                }
              } else {
                if(widget.isDarkPicker) {
                  setState(() {
                    error = true;
                    errorMessage = "Color is too dark";
                  });
                }
              }

              if(!error) {
                Navigator.pop(context, textColor);
              }
            } else {
              setState(() {
                error = true;
                errorMessage = "Not a valid hex color";
              });
            }
          },
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).dialogBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          ),
        ),
      ],
    );
  }
}