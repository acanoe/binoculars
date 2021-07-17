import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../components/title_bar.dart';
import '../controllers/home.dart';
import '../services/db.dart';

class MorePage extends StatelessWidget {
  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleBar(title: 'More'),
        Expanded(
          child: ShowUpAnimation(
            animationDuration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutExpo,
            direction: Direction.vertical,
            delayStart: const Duration(milliseconds: 150),
            offset: 0.2,
            child: ListView(
              children: [
                ListTile(
                  title: Text('Sort type'),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(_homeController.filter.capitalizeFirst),
                  ),
                  onTap: () {
                    Get.generalDialog(pageBuilder: (context, _, __) {
                      return Text('data');
                    });
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: DbService().settings.listenable(
                    keys: ['darkMode'],
                  ),
                  builder: (context, box, widget) {
                    bool status = box.get(
                      'darkMode',
                      defaultValue: false,
                    );

                    return SwitchListTile(
                      title: Text('Dark mode'),
                      value: status,
                      onChanged: (val) => box.put('darkMode', val),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
