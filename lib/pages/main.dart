import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../components/images_grid.dart';
import '../components/title_bar.dart';
import '../controllers/home.dart';
import 'more.dart';
import 'post.dart';
import 'subscriptions.dart';

class MainPage extends StatelessWidget {
  final _pageController = PageController(initialPage: 1);
  final _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            SubscriptionsPage(),
            GetBuilder<HomeController>(
              init: HomeController(),
              initState: (_) => _homeController.getPosts(),
              builder: (_) {
                return Column(
                  children: [
                    TitleBar(
                      bigTitle: true,
                      title: 'Binoculars',
                    ),
                    Expanded(
                      child: _homeController.posts.isNotEmpty
                          ? ImagesGrid(
                              posts: _homeController.posts,
                              onTap: (post) {
                                return Get.to(() => PostPage(post: post));
                              },
                              onRefresh: () => _homeController.getPosts(),
                            )
                          : _loading(context),
                    ),
                  ],
                );
              },
            ),
            MorePage(),
          ],
        ),
      ),
    );
  }

  Widget _loading(BuildContext context) {
    return ShowUpAnimation(
      animationDuration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutExpo,
      direction: Direction.vertical,
      delayStart: const Duration(milliseconds: 150),
      offset: 0.2,
      child: Center(
        child: GestureDetector(
          onTap: () => _homeController.getPosts(),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
