import 'package:flutter/material.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class BottomAppSheet extends StatefulWidget {
  AnimationController controller;
  CurrentMenuPages currentPage;
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
    Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
    Animatable<double> _positionTween = Tween<double>(begin: 64, end: (50 * 7.0) + 4 + 64);
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
                              child: Icon(Icons.swap_vertical_circle),
                            ),
                            Text(
                              "Quick Settings",
                              style: TextStyle(
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Spacer(),
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
                              SizeableListTile(
                                icon: Icon(Icons.swap_vertical_circle),
                                title: "Quick Settings",
                                height: 50,
                                onTap: () {
                                  widget.onItemClick(0);
                                },
                              ),
                              SizeableListTile(
                                icon: Icon(Icons.space_bar),
                                title: "Status bar",
                                height: 50,
                                onTap: () {
                                  widget.onItemClick(0);
                                },
                              ),
                              SizeableListTile(
                                icon: Icon(Icons.colorize),
                                title: "Themes",
                                height: 50,
                                onTap: () {
                                  widget.onItemClick(0);
                                },
                              ),
                              SizeableListTile(
                                icon: Icon(Icons.touch_app),
                                title: "Buttons and navigation",
                                height: 50,
                                onTap: () {
                                  widget.onItemClick(0);
                                },
                              ),
                              Divider(
                                height: 2,
                              ),
                              SizeableListTile(
                                icon: Icon(Icons.system_update),
                                title: "Open Potato Center",
                                height: 50,
                                onTap: () {
                                  widget.onItemClick(0);
                                },
                              ),
                              SizeableListTile(
                                icon: Icon(Icons.person),
                                title: "Discover POSP team",
                                height: 50,
                                onTap: () {
                                  launchUrl("https://potatoproject.co/team");
                                },
                              ),
                              SizeableListTile(
                                icon: Icon(Icons.info),
                                title: "General info",
                                height: 50,
                                onTap: () {
                                  widget.onItemClick(0);
                                },
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