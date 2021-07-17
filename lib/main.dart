import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'services/db.dart';
import 'services/reddit.dart';
import 'services/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

Future initServices() async {
  print('starting services ...');
  await Get.putAsync(() => DbService().init());
  await Get.putAsync(() => RedditService().init());
  if (Platform.isAndroid) Get.put(() => StorageService());
  print('All services started...');
}
