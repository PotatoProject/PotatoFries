import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/backend/data.dart';
import 'package:potato_fries/backend/models/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _FriesHomeState createState() => _FriesHomeState();
}

class _FriesHomeState extends State<HomePage> {
  int pageIndex = 0;
  FriesPage get currentPage => Pages.list[pageIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fries"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/search'),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: Material(
              type: MaterialType.transparency,
              child: child,
            ),
          );
        },
        child: IndexedStack(
          key: ValueKey(pageIndex),
          index: pageIndex,
          children: Pages.list.map((e) => e.build(context)).toList(),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (index) => setState(() => pageIndex = index),
        destinations: Pages.list.map((e) => e.destination).toList(),
      ),
    );
  }
}
