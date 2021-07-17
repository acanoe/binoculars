import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbService extends GetxService {
  Box get settings => Hive.box('settings');
  Box get subscriptions => Hive.box('subscriptions');

  Future<DbService> init() async {
    await Hive.initFlutter();
    await Hive.openBox('settings');
    await Hive.openBox('subscriptions');
    return this;
  }
}
