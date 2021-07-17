import 'package:get/get.dart';

import '../models/response.dart';
import '../services/db.dart';
import '../services/reddit.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  static final dbService = DbService();
  static final redditService = RedditService();

  List<String> filters = ['Hot', 'New', 'Controversial', 'Top', 'Rising'];
  List<Post> posts = [];
  String filter = 'hot';

  Future<void> getPosts({List<String> subreddits}) async {
    List<String> subs = subreddits != null
        ? subreddits
        : dbService.subscriptions.values.isNotEmpty
            ? List<String>.from(dbService.subscriptions.values)
            : ['memes', 'funny', 'pics', 'foodporn', 'earthporn'];

    posts = await redditService.getItems(
      subreddit: subs.join('+'),
      filter: filter,
    );
    update();
  }
}
