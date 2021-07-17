import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home.dart';
import '../services/db.dart';

class AddNewSubscription extends StatelessWidget {
  final bool fullMode;

  const AddNewSubscription({Key key, this.fullMode = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: fullMode
          ? InkWell(
              onTap: () async => showAddSubscriptionForm(context),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Add subreddit'),
                    Icon(Icons.add, size: 56.0),
                  ],
                ),
              ),
            )
          : IconButton(
              onPressed: () async => showAddSubscriptionForm(context),
              icon: Icon(
                Icons.add,
              ),
              iconSize: 40.0,
            ),
    );
  }

  Future<void> showAddSubscriptionForm(BuildContext context) {
    return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.fromLTRB(
          24.0,
          24.0,
          24.0,
          0.0,
        ),
        child: ValueBuilder<String>(
          initialValue: '',
          builder: (value, update) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add new Subscriptions'),
                const SizedBox(height: 16.0),
                TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefix: Text('r/'),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => update(val),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      DbService().subscriptions.add(value);
                      HomeController.to.getPosts();
                      Get.back();
                    },
                    child: Text('Add'),
                  ),
                )
              ],
            );
          },
        ),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.grey[100],
    );
  }
}
