import 'package:flutter/material.dart';
import 'package:potato_fries/internal/common.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class BottomAppSheet extends StatefulWidget {
  AnimationController controller;
  int currentPage;
  Function(int index) onItemClick;

  BottomAppSheet({
    @required this.controller,
    @required this.currentPage,
    @required this.onItemClick,
  });

  @override
  createState() => _BottomAppSheetState();
}

class _BottomAppSheetState extends State<BottomAppSheet> {
  @override
  Widget build(BuildContext context) {
    double totalHeight = 2.0 + 64 + (50 * FriesPage.pages.length);
    Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
    Animatable<double> _positionTween = Tween<double>(begin: 64, end: totalHeight);
    Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

    Animation<double> _iconTurns = widget.controller.drive(_halfTween.chain(_easeInTween));
    Animation<double> _positionChange = widget.controller.drive(_positionTween.chain(_easeInTween));

    return AnimatedBuilder(
      animation: _positionChange,
      builder: (context, child) => Positioned(
        width: MediaQuery.of(context).size.width,
        top: (MediaQuery.of(context).size.height - 64) - (_positionChange.value - 64),
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
              )
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
                              child: Icon(FriesPage.pages[widget.currentPage].icon),
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
                              onPressed: () => launchUrl("https://potatoproject.co/team"),
                              tooltip: "Discover POSP team",
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.info),
                              onPressed: () {},
                              tooltip: "General info",
                            ),
                            Spacer(flex: 3),
                            IconButton(
                              icon: RotationTransition(
                                turns: _iconTurns,
                                child: Icon(
                                  Icons.expand_less,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              onPressed: () {
                                if(widget.controller.status == AnimationStatus.completed) {
                                  widget.controller.reverse();
                                } else {
                                  widget.controller.forward();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                Visibility(
                  visible: widget.controller.value > 0,
                  child: AnimatedBuilder(
                    animation: Tween<double>(begin: 0, end: 1).animate(widget.controller),
                    builder: (context, child) {
                      return Opacity(
                        opacity: widget.controller.value,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Divider(
                                height: 2,
                              ),
                              Column(
                                children: pageSwitcherItemsBuilder,
                              ),
                            ]
                          ),
                        ),
                      );
                    },
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

    for(int i = 0; i < FriesPage.pages.length; i++) {
      widgets.add(
        SizeableListTile(
          icon: Icon(FriesPage.pages[i].icon),
          title: FriesPage.pages[i].title,
          height: 50,
          onTap: () {
            widget.onItemClick(i);
          },
          elementsColor: Theme.of(context).textTheme.title.color,
          selected: widget.currentPage == i,
          selectedColor: Theme.of(context).accentColor,
        ),
      );
    }

    return widgets;
  }

  void _onDrag(DragUpdateDetails details) {
    widget.controller.value -= details.primaryDelta / ((50 * 7.0) + 4 + 64 - 64);
  }

  void _onDragEnd(DragEndDetails details) {
    double minFlingVelocity = 365.0;

    //let the current animation finish before starting a new one
    if(widget.controller.isAnimating) return;

    //check if the velocity is sufficient to constitute fling
    if(details.velocity.pixelsPerSecond.dy.abs() >= minFlingVelocity){
      double visualVelocity = - details.velocity.pixelsPerSecond.dy / ((50 * 7.0) + 4 + 64 - 64);

      widget.controller.fling(velocity: visualVelocity);

      return;
    }
    
    if(widget.controller.value > 0.5)
      _open();
    else
      _close();
  }

  void _close(){
    widget.controller.fling(velocity: -1.0);
  }

  //open the panel
  void _open(){
    widget.controller.fling(velocity: 1.0);
  }
}