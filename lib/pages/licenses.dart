import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LicensesPage extends StatefulWidget {
  const LicensesPage({Key? key}) : super(key: key);

  @override
  _LicensesPageState createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  final Future<_LicenseData> licenses = LicenseRegistry.licenses
      .fold<_LicenseData>(
        _LicenseData(),
        (_LicenseData prev, LicenseEntry license) => prev..addLicense(license),
      )
      .then((_LicenseData licenseData) => licenseData..sortPackages());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open source licenses'),
      ),
      body: FutureBuilder<_LicenseData>(
        future: licenses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scrollbar(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final String package = snapshot.data!.packages[index];
                  final List<int> bindings =
                      snapshot.data!.packageLicenseBindings[package]!;

                  return ListTile(
                    title: Text(package),
                    subtitle: Text(
                      MaterialLocalizations.of(context)
                          .licensesPackageDetailText(bindings.length),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => _PackageLicensesPage(
                            packageName: package,
                            licenseEntries: bindings
                                .map((int i) => snapshot.data!.licenses[i])
                                .toList(growable: false),
                          ),
                        ),
                      );
                    },
                  );
                },
                itemCount: snapshot.data!.packages.length,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _LicenseData {
  final List<LicenseEntry> licenses = <LicenseEntry>[];
  final Map<String, List<int>> packageLicenseBindings = <String, List<int>>{};
  final List<String> packages = <String>[];

  String? firstPackage;

  void addLicense(LicenseEntry entry) {
    for (final String package in entry.packages) {
      _addPackage(package);
      packageLicenseBindings[package]!.add(licenses.length);
    }
    licenses.add(entry);
  }

  void _addPackage(String package) {
    if (!packageLicenseBindings.containsKey(package)) {
      packageLicenseBindings[package] = <int>[];
      firstPackage ??= package;
      packages.add(package);
    }
  }

  void sortPackages([int Function(String a, String b)? compare]) {
    packages.sort(
      compare ??
          (String a, String b) {
            if (a == firstPackage) {
              return -1;
            }
            if (b == firstPackage) {
              return 1;
            }
            return a.toLowerCase().compareTo(b.toLowerCase());
          },
    );
  }
}

class _PackageLicensesPage extends StatefulWidget {
  final String packageName;
  final List<LicenseEntry> licenseEntries;

  const _PackageLicensesPage({
    required this.packageName,
    required this.licenseEntries,
  });

  @override
  _PackageLicensesPageState createState() => _PackageLicensesPageState();
}

class _PackageLicensesPageState extends State<_PackageLicensesPage> {
  final List<Widget> _licenses = <Widget>[];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _initLicenses();
  }

  void _initLicenses() async {
    for (final LicenseEntry license in widget.licenseEntries) {
      if (!mounted) {
        return;
      }
      final List<LicenseParagraph> paragraphs =
          await SchedulerBinding.instance!.scheduleTask<List<LicenseParagraph>>(
        license.paragraphs.toList,
        Priority.animation,
        debugLabel: 'License',
      );
      if (!mounted) {
        return;
      }
      _licenses.add(const Divider(height: 1));
      for (final LicenseParagraph paragraph in paragraphs) {
        if (paragraph.indent == LicenseParagraph.centeredIndent) {
          _licenses.add(
            Padding(
              padding: const EdgeInsets.all(64.0),
              child: Text(
                paragraph.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          assert(paragraph.indent >= 0);
          _licenses.add(
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: 8.0,
                start: 16.0 * paragraph.indent + 16.0,
                end: 16.0,
                bottom: 8.0,
              ),
              child: Text(paragraph.text),
            ),
          );
        }
      }
    }
    setState(() {
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('"${widget.packageName}" licenses'),
      ),
      body: Builder(
        builder: (context) {
          if (_loaded) {
            return Scrollbar(
              child: ListView.builder(
                itemBuilder: (context, index) => _licenses[index],
                itemCount: _licenses.length,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
