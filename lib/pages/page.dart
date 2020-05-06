import 'package:flutter/material.dart';

abstract class Page extends StatelessWidget {
  String get title;
  IconData get icon;
  String get providerKey;
}
