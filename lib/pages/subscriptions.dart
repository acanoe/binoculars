import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../components/add_subscription.dart';
import '../components/subscription_list.dart';
import '../components/title_bar.dart';
import '../services/db.dart';

class SubscriptionsPage extends StatelessWidget {
  final Box subscriptions = DbService().subscriptions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              TitleBar(
                title: 'Subscriptions',
                trailing: Row(
                  children: [
                    subscriptions.values.isNotEmpty
                        ? AddNewSubscription(fullMode: false)
                        : const SizedBox(),
                  ],
                ),
              ),
              Expanded(
                child: subscriptions.values.isNotEmpty
                    ? SubscriptionList(subscriptions: subscriptions)
                    : AddNewSubscription(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
