import 'package:flutter/material.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/ui/croquette_badge.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class BottomAppSheet extends StatefulWidget {
  final AnimationController controller;
  final int currentPage;
  final Function(int index) onItemClick;

  BottomAppSheet({
    @required this.controller,
    @required this.currentPage,
    @required this.onItemClick,
  });

  static Animation<double> _iconTurns;
  static Animation<double> _positionChange;

  static double totalHeight = 2.0 + 64 + (50 * pages.length);
  static Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
  static Animatable<double> _positionTween =
      Tween<double>(begin: 64, end: totalHeight);
  static Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

  @override
  _BottomAppSheetState createState() => _BottomAppSheetState();
}

class _BottomAppSheetState extends State<BottomAppSheet> {
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
            FlatButton(
              child: Text("CLOSE"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BottomAppSheet._iconTurns ??= widget.controller
        .drive(BottomAppSheet._halfTween.chain(BottomAppSheet._easeInTween));
    BottomAppSheet._positionChange ??= widget.controller.drive(
        BottomAppSheet._positionTween.chain(BottomAppSheet._easeInTween));
    return AnimatedBuilder(
      animation: BottomAppSheet._positionChange,
      builder: (context, child) => Positioned(
        width: MediaQuery.of(context).size.width,
        top: (MediaQuery.of(context).size.height - 64) -
            (BottomAppSheet._positionChange.value - 64),
        child: GestureDetector(
          onVerticalDragUpdate: _onDrag,
          onVerticalDragEnd: _onDragEnd,
          child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            margin: EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 64,
                  child: Stack(
                    alignment: Alignment.center,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        height: 64,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                  (pages[widget.currentPage] as dynamic).icon),
                            ),
                            Spacer(flex: 3),
                            IconButton(
                              icon: Icon(Icons.system_update),
                              onPressed: () {},
                              tooltip: "Open Potato Center",
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.person),
                              onPressed: () =>
                                  launchUrl("https://potatoproject.co/team"),
                              tooltip: "Discover POSP team",
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.info),
                              onPressed: _showDialog,
                              tooltip: "Build info",
                            ),
                            Spacer(flex: 3),
                            IconButton(
                              icon: RotationTransition(
                                turns: BottomAppSheet._iconTurns,
                                child: Icon(
                                  Icons.expand_less,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              onPressed: () => widget.controller.status ==
                                      AnimationStatus.completed
                                  ? widget.controller.reverse()
                                  : widget.controller.forward(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.controller.value > 0,
                  child: AnimatedBuilder(
                    animation: Tween<double>(begin: 0, end: 1)
                        .animate(widget.controller),
                    builder: (context, child) => Opacity(
                      opacity: widget.controller.value,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Divider(height: 2),
                            Column(children: pageSwitcherItemsBuilder),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get pageSwitcherItemsBuilder {
    List<Widget> widgets = [];

    for (int i = 0; i < pages.length; i++) {
      widgets.add(
        Builder(
          builder: (context) => SizeableListTile(
            icon: Icon((pages[i] as dynamic).icon),
            title: (pages[i] as dynamic).title,
            height: 50,
            onTap: () => widget.onItemClick(i),
            elementsColor: Theme.of(context).textTheme.title.color,
            selected: widget.currentPage == i,
            selectedColor: Theme.of(context).accentColor,
          ),
        ),
      );
    }

    return widgets;
  }

  void _onDrag(DragUpdateDetails details) => widget.controller.value -=
      details.primaryDelta / ((50 * 7.0) + 4 + 64 - 64);

  void _onDragEnd(DragEndDetails details) {
    double minFlingVelocity = 365.0;

    //let the current animation finish before starting a new one
    if (widget.controller.isAnimating) return;

    //check if the velocity is sufficient to constitute fling
    if (details.velocity.pixelsPerSecond.dy.abs() >= minFlingVelocity) {
      double visualVelocity =
          -details.velocity.pixelsPerSecond.dy / ((50 * 7.0) + 4 + 64 - 64);

      widget.controller.fling(velocity: visualVelocity);

      return;
    }

    if (widget.controller.value > 0.5)
      _open();
    else
      _close();
  }

  void _close() => widget.controller.fling(velocity: -1.0);

  void _open() => widget.controller.fling(velocity: 1.0);
}
