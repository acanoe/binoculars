import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../controllers/home.dart';

class SubscriptionList extends StatelessWidget {
  final Box subscriptions;

  const SubscriptionList({
    Key key,
    @required this.subscriptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      animationDuration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutExpo,
      direction: Direction.vertical,
      delayStart: const Duration(milliseconds: 150),
      offset: 0.2,
      child: ValueListenableBuilder(
        valueListenable: subscriptions.listenable(),
        builder: (context, Box box, widget) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(box.getAt(index)),
                onLongPress: () {
                  box.deleteAt(index);
                  HomeController.to.getPosts();
                },
              );
            },
          );
        },
      ),
    );
  }
}
