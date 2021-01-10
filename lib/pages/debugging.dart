import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_switch.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:spicy_components/spicy_components.dart';

class DebuggingPage extends StatefulWidget {
  @override
  _DebuggingPageState createState() => _DebuggingPageState();
}

class _DebuggingPageState extends State<DebuggingPage> {
  bool discoEnabled = false;
  final discoProp = 'persist.sys.theme.accent_disco';

  @override
  void initState() {
    super.initState();
    updateDisco();
  }

  void updateDisco() async {
    var propData = await AndroidFlutterSettings.getProp(PropKey(discoProp));
    discoEnabled = propData != null && propData != "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var appInfoProvider = Provider.of<AppInfoProvider>(context);
    var verNum = appInfoProvider.hostVersion.toString() ?? "Invalid Version!";
    // ignore: non_constant_identifier_names
    var DEBUG = false;
    assert(DEBUG = true);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            header("Build Info"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .headline6
                      .color
                      .withOpacity(0.7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Fries build: ",
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6
                                .color
                                .withOpacity(0.9),
                          ),
                        ),
                        FutureBuilder<PackageInfo>(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) return Container();
                            return Text(
                              snapshot.data.version +
                                  '+' +
                                  snapshot.data.buildNumber,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .color
                                    .withOpacity(0.7),
                              ),
                            );
                          },
                        ),
                        Visibility(
                          visible: DEBUG,
                          child: Text(
                            " (DEBUG)",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Version number: ",
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6
                                .color
                                .withOpacity(0.9),
                          ),
                        ),
                        Text(
                          verNum,
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6
                                .color
                                .withOpacity(0.7),
                          ),
                        ),
                        Visibility(
                          visible: appInfoProvider.getVersionOverride() != null,
                          child: Text(
                            " (FAKE)",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    buildInfoRow(
                      "Build type: ",
                      "${appInfoProvider.dish} - ${appInfoProvider.type}",
                    ),
                    buildInfoRow(
                      "Device info: ",
                      "${appInfoProvider.model} (${appInfoProvider.device})",
                    ),
                    buildInfoRow(
                      "Build name: ",
                      appInfoProvider.exactBuild,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  header("Version and compatibility"),
                  SizeableListTile(
                    title: "Disable version checking",
                    icon: Icon(Icons.track_changes_outlined),
                    subtitle: Text("Disable all non-strict version checks"),
                    trailing: SettingsSwitch(
                      setValue: (v) =>
                          appInfoProvider.setVersionCheckDisabled(v),
                      value: appInfoProvider.isVersionCheckDisabled(),
                    ),
                    onTap: () => appInfoProvider.setVersionCheckDisabled(
                        !appInfoProvider.isVersionCheckDisabled()),
                  ),
                  SizeableListTile(
                    title: "Disable compatibility checking",
                    icon: Icon(Icons.developer_board_outlined),
                    subtitle: Text("Disable all feature compatibility checks"),
                    trailing: SettingsSwitch(
                      setValue: (v) =>
                          appInfoProvider.setCompatCheckDisabled(v),
                      value: appInfoProvider.isCompatCheckDisabled(),
                    ),
                    onTap: () => appInfoProvider.setCompatCheckDisabled(
                        !appInfoProvider.isCompatCheckDisabled()),
                  ),
                  SizeableListTile(
                    title: "Spoof version",
                    icon: Icon(Icons.flash_on_outlined),
                    subtitle: Text(appInfoProvider.getVersionOverride() == null
                        ? 'Set a fake vernum'
                        : 'Fake version: ' +
                            appInfoProvider.getVersionOverride().toString()),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => VersionChanger(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  header("Activity"),
                  SizeableListTile(
                    title: "Launch Activity",
                    icon: Icon(Icons.launch_outlined),
                    subtitle: Text('Start any activity'),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ActivityLaunch(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  header("Settings"),
                  SizeableListTile(
                    title: "Write or read settings",
                    icon: Icon(Icons.settings_outlined),
                    subtitle:
                        Text('Write or read any System/Secure/Global settings'),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => SettingsControl(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomAnimation(
        control: discoEnabled
            ? CustomAnimationControl.LOOP
            : CustomAnimationControl.STOP,
        tween: Tween<double>(begin: 0, end: 360),
        duration: Duration(seconds: 5),
        builder: (context, _, anim) {
          HSLColor rainbow = HSLColor.fromAHSL(
            1.0,
            anim,
            1,
            0.5,
          );
          Color textColor = rainbow.toColor().computeLuminance() > 0.5
              ? Colors.black
              : Colors.white;

          return SpicyBottomBar(
            bgColor: discoEnabled
                ? rainbow.toColor()
                : Theme.of(context).accentColor,
            leftItems: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                color: discoEnabled
                    ? textColor.withOpacity(0.7)
                    : Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                padding: EdgeInsets.all(0),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                'Debug menu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: discoEnabled
                      ? textColor.withOpacity(0.7)
                      : Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget header(String text) => Builder(
        builder: (context) {
          TextStyle heading = TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 2,
          );

          return Text(
            text.toUpperCase(),
            style: heading,
          );
        },
      );

  Widget buildInfoRow(String title, String content) => Builder(
        builder: (context) {
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .headline6
                        .color
                        .withOpacity(0.9),
                  ),
                ),
                TextSpan(
                  text: content,
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .headline6
                        .color
                        .withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class VersionChanger extends StatefulWidget {
  @override
  _VersionChangerState createState() => _VersionChangerState();
}

class _VersionChangerState extends State<VersionChanger> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Spoof fake POSP version'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Version'),
              validator: (value) {
                try {
                  BuildVersion.parse(value);
                  return null;
                } on ArgumentError {
                  return "Invalid version!";
                }
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            Provider.of<AppInfoProvider>(context, listen: false)
                .setVersionOverride(null);
            Navigator.of(context).pop();
          },
          child: Text('Reset'),
        ),
        FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Provider.of<AppInfoProvider>(context, listen: false)
                  .setVersionOverride(BuildVersion.parse(_controller.text));
              Navigator.of(context).pop();
            }
          },
          child: Text('Apply'),
        ),
      ],
    );
  }
}

class ActivityLaunch extends StatefulWidget {
  @override
  _ActivityLaunchState createState() => _ActivityLaunchState();
}

class _ActivityLaunchState extends State<ActivityLaunch> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerPkg = TextEditingController();
  final TextEditingController _controllerCls = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Activity launcher'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controllerPkg,
                  decoration: InputDecoration(hintText: 'Package'),
                  validator: (value) {
                    if (value != null && value.isNotEmpty)
                      return null;
                    else
                      return "This cannot be empty!";
                  },
                ),
                TextFormField(
                  controller: _controllerCls,
                  decoration: InputDecoration(hintText: 'Class'),
                  validator: (value) {
                    if (value != null && value.isNotEmpty)
                      return null;
                    else
                      return "This cannot be empty!";
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Utils.startActivity(
                pkg: _controllerPkg.text,
                cls: _controllerCls.text,
              );
            }
          },
          child: Text(
            'Launch',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
      ],
    );
  }
}

class SettingsControl extends StatefulWidget {
  @override
  _SettingsControlState createState() => _SettingsControlState();
}

class _SettingsControlState extends State<SettingsControl> {
  final TextEditingController _controllerRead = TextEditingController();
  final TextEditingController _controllerWriteSetting = TextEditingController();
  final TextEditingController _controllerWriteData = TextEditingController();
  final _formKeyRead = GlobalKey<FormState>();
  final _formKeyWrite = GlobalKey<FormState>();

  SettingType typeRead = SettingType.SYSTEM;
  SettingType typeWrite = SettingType.SYSTEM;
  String readResult;
  String writeResult;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Read",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              DropdownButton(
                isDense: true,
                value: SettingType.SYSTEM,
                items: SettingType.values
                    .map(
                      (k) => DropdownMenuItem(
                        value: k,
                        child: Text(k.toString().split('.')[1]),
                      ),
                    )
                    .toList(),
                onChanged: (_value) => setState(() => typeRead = _value),
                underline: Container(),
              ),
            ],
          ),
          Form(
            key: _formKeyRead,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                      controller: _controllerRead,
                      decoration: InputDecoration(hintText: 'Setting to read'),
                      validator: (value) {
                        if (value != null && value.isNotEmpty)
                          return null;
                        else
                          return "This cannot be empty!";
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: MaterialButton(
                    minWidth: 80,
                    child: Text("Read"),
                    onPressed: () async {
                      if (_formKeyRead.currentState.validate()) {
                        readResult = await AndroidFlutterSettings.getString(
                          SettingKey(_controllerRead.text, typeRead),
                        );
                        setState(() {});
                      }
                    },
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: readResult != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Read: $readResult'),
            ),
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Write",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              DropdownButton(
                isDense: true,
                value: SettingType.SYSTEM,
                items: SettingType.values
                    .map(
                      (k) => DropdownMenuItem(
                        value: k,
                        child: Text(k.toString().split('.')[1]),
                      ),
                    )
                    .toList(),
                onChanged: (_value) => setState(() => typeWrite = _value),
                underline: Container(),
              ),
            ],
          ),
          Form(
            key: _formKeyWrite,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: _controllerWriteSetting,
                          decoration:
                              InputDecoration(hintText: 'Setting to write'),
                          validator: (value) {
                            if (value != null && value.isNotEmpty)
                              return null;
                            else
                              return "This cannot be empty!";
                          }),
                      TextFormField(
                          controller: _controllerWriteData,
                          decoration:
                              InputDecoration(hintText: 'Data to write'),
                          validator: (value) {
                            if (value != null && value.isNotEmpty)
                              return null;
                            else
                              return "This cannot be empty!";
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: MaterialButton(
                    height: 80,
                    minWidth: 80,
                    child: Text("Write"),
                    onPressed: () async {
                      if (_formKeyWrite.currentState.validate()) {
                        await AndroidFlutterSettings.putString(
                          SettingKey(_controllerWriteSetting.text, typeWrite),
                          _controllerWriteData.text,
                        );
                        writeResult = await AndroidFlutterSettings.getString(
                          SettingKey(_controllerWriteSetting.text, typeWrite),
                        );
                        setState(() {});
                      }
                    },
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: writeResult != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Write: $writeResult'),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}
