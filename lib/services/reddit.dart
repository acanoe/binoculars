import 'package:binoculars/models/response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RedditService extends GetxService {
  static Dio dio;
  static String baseUrl = 'https://www.reddit.com/';

  Future<RedditService> init() async {
    dio = new Dio();
    return this;
  }

  static String buildSubredditUrl({String subreddit, String filter}) {
    return '${baseUrl}r/$subreddit/$filter.json?limit=50';
  }

  static String buildSearchUrl({String query}) {
    query = query.replaceAll(' ', '%20');
    return '${baseUrl}search.json?q=$query&type=link';
  }

  Future<List<Post>> getItems({String subreddit, String filter = 'hot'}) async {
    List<Post> _posts = [];

    try {
      var response = await dio.get(
        buildSubredditUrl(
          subreddit: subreddit,
          filter: filter,
        ),
      );

      if (response.statusCode == 200) {
        Reddit temp = Reddit.fromJson(response.data);
        temp.data.children.forEach((children) {
          if (children.post.postHint == 'image') {
            _posts.add(children.post);
          }
        });
      } else {
        print('Error: ' + response.request.toString());
      }
    } catch (e) {
      print('Error: ' + e.toString());
    }

    return _posts;
  }

  Resolutions getThumbnail(Post post) {
    return post.preview.images[0].resolutions.length <= 3
        ? post.preview.images[0].resolutions.last
        : post.preview.images[0].resolutions[3];
  }

  String getThumbnailUrl(Post post) {
    return getThumbnail(post).url.replaceAll('amp;', '');
  }

  double getThumbnailAspectRatio(Post post) {
    return getThumbnail(post).width / getThumbnail(post).height;
  }
}
