import 'package:flutter/material.dart';

class OverlayHelper extends StatefulWidget {
  final Widget icon, content;
  final AnimationController controller;
  final Animation<double> animation;

  const OverlayHelper({
    Key key,
    this.icon,
    this.content,
    this.controller,
    this.animation,
  }) : super(key: key);

  @override
  State<OverlayHelper> createState() => _OverlayHelperState();
}

class _OverlayHelperState extends State<OverlayHelper> {
  GlobalKey _iconKey;

  OverlayEntry _overlayEntry;

  Size buttonSize;

  Offset buttonPosition;

  bool isMenuOpen = false;

  void findButton() {
    RenderBox renderBox = _iconKey.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  Future<void> openMenu() async {
    findButton();

    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = true;
    widget.controller.forward();
  }

  Future<void> closeMenu() async {
    await widget.controller.reverse();
    _overlayEntry?.remove();
    isMenuOpen = false;
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTapDown: (_) => closeMenu(),
                behavior: HitTestBehavior.translucent,
              ),
            ),
            Positioned(
              top: buttonPosition.dy + buttonSize.height - 20,
              left: buttonPosition.dx + (buttonSize.height  / 2),
              child: ScaleTransition(
                scale: widget.animation,
                alignment: Alignment.topLeft,
                child: widget.content,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _iconKey = LabeledGlobalKey('${widget.key}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _iconKey,
      child: widget.icon,
      onTap: () {
        if (isMenuOpen) {
          closeMenu();
        } else {
          openMenu();
        }
      },
    );
  }
}
