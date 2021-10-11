import 'package:flutter/material.dart';

import 'custom_overlay_helper.dart';
import 'model.dart';

class ListItem extends StatelessWidget {
  final Model model;
  final Function onTap;
  final AnimationController controller;
  final Animation<double> animation;

  const ListItem({
    Key key,
    this.model,
    this.onTap,
    this.controller,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[200],
      ),
      title: Text(model.title),
      subtitle: Text(model.subTitle),
      onTap: onTap,
      trailing: OverlayHelper(
        key: Key(model.id.toString()),
        controller: controller,
        animation: animation,
        icon: const Icon(Icons.more),
        content: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            child: Column(
              children: List.generate(4, (index) => Text('item $index')),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400].withOpacity(0.5),
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                  spreadRadius: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
