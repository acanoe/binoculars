import 'package:binoculars/models/response.dart';
import 'package:binoculars/services/reddit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ImagesGrid extends StatelessWidget {
  final List<Post> posts;
  final VoidCallback onRefresh;
  final Function(Post post) onTap;

  const ImagesGrid({Key key, @required this.posts, this.onRefresh, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      animationDuration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutExpo,
      direction: Direction.vertical,
      delayStart: const Duration(milliseconds: 150),
      offset: 0.2,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: posts.length,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          itemBuilder: (BuildContext context, int index) {
            var post = posts[index];
            return InkWell(
              onTap: () => onTap(post),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return AspectRatio(
                    aspectRatio: RedditService().getThumbnailAspectRatio(post),
                    child: LinearProgressIndicator(
                      value: downloadProgress.progress,
                      valueColor:
                          AlwaysStoppedAnimation(Theme.of(context).accentColor),
                    ),
                  );
                },
                imageUrl: RedditService().getThumbnailUrl(post),
              ),
            );
          },
        ),
      ),
    );
  }
}
