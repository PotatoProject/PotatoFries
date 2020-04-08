import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/app_native/utils.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/widgets/settings_switch.dart';
import 'package:provider/provider.dart';

class DebuggingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle heading = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    var appInfoProvider = Provider.of<AppInfoProvider>(context);
    var verNum =
        verNumString(appInfoProvider.hostVersion) ?? "Invalid Version!";
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Advanced options'),
            Icon(Icons.bug_report),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Build Info", style: heading),
                  Row(
                    children: <Widget>[
                      Text(verNum),
                      Visibility(
                        visible: appInfoProvider.getVersionOverride() != null,
                        child: Text(" (FAKE)",
                            style: TextStyle(color: Colors.red)),
                      )
                    ],
                  ),
                  Text("${appInfoProvider.dish} - ${appInfoProvider.type}"),
                  Text("${appInfoProvider.model} (${appInfoProvider.device})"),
                  Text(appInfoProvider.exactBuild),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Version and compatibility", style: heading),
                  SizeableListTile(
                    title: "Disable version checking",
                    icon: Icon(Icons.track_changes),
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
                    icon: Icon(Icons.developer_board),
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
                    icon: Icon(Icons.flash_on),
                    subtitle: Text(appInfoProvider.getVersionOverride() == null
                        ? 'Set a fake vernum'
                        : 'Fake version: ' +
                            verNumString(appInfoProvider.getVersionOverride())),
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
                  Text("Activity", style: heading),
                  SizeableListTile(
                    title: "Launch Activity",
                    icon: Icon(Icons.launch),
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
                  Text("Settings and overlays", style: heading),
                  SizeableListTile(
                    title: "Write or read settings",
                    icon: Icon(Icons.settings),
                    subtitle:
                        Text('Write or read any System/Secure/Global settings'),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => SettingsControl(),
                    ),
                  ),
                  SizeableListTile(
                    title: "Overlay Controller",
                    icon: Icon(Icons.layers),
                    subtitle: Text(
                      'Enable/disable any overlay, trigger asset reload for a package',
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => OverlayControl(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                validator: (value) => isVersionValid(parseVerNum(value))
                    ? null
                    : "Invalid version!"),
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
                  .setVersionOverride(parseVerNum(_controller.text));
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
                          _controllerRead.text,
                          typeRead,
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
                            _controllerWriteSetting.text,
                            _controllerWriteData.text,
                            typeWrite);
                        writeResult = await AndroidFlutterSettings.getString(
                          _controllerWriteSetting.text,
                          typeWrite,
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

class OverlayControl extends StatefulWidget {
  @override
  _OverlayControlState createState() => _OverlayControlState();
}

class _OverlayControlState extends State<OverlayControl> {
  final _formKeyOverlay = GlobalKey<FormState>();
  final _formKeyTarget = GlobalKey<FormState>();

  final TextEditingController _controllerOverlayPkg = TextEditingController();
  final TextEditingController _controllerTargetPkg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: Text('Overlay controller'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Overlay",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          Form(
            key: _formKeyOverlay,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controllerOverlayPkg,
                  decoration: InputDecoration(hintText: 'Overlay package name'),
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
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    if (_formKeyOverlay.currentState.validate()) {
                      AndroidFlutterSettings.overlaySetEnabled(
                          _controllerOverlayPkg.text, true);
                    }
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Enable'),
                ),
                SizedBox(width: 16),
                MaterialButton(
                  onPressed: () {
                    if (_formKeyOverlay.currentState.validate()) {
                      AndroidFlutterSettings.overlaySetEnabled(
                          _controllerOverlayPkg.text, false);
                    }
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Disable'),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Package",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          Form(
            key: _formKeyTarget,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controllerTargetPkg,
                  decoration: InputDecoration(hintText: 'Target package name'),
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
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    if (_formKeyTarget.currentState.validate()) {
                      AndroidFlutterSettings.reloadAssets(
                          _controllerTargetPkg.text);
                    }
                  },
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  child: Text('Asset Reload'),
                ),
              ],
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
