import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/response.dart';
import '../services/reddit.dart';
import '../services/storage.dart';

class PostPage extends StatelessWidget {
  final Post post;

  const PostPage({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return AspectRatio(
                  aspectRatio: RedditService().getThumbnailAspectRatio(post),
                  child: Center(
                    child: Text(
                      downloadProgress.progress != null
                          ? '${(downloadProgress.progress * 100.0).truncate()}%\n${(downloadProgress.totalSize / 1048576).toStringAsFixed(1)} Mb'
                          : 'Loading',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) {
                return PinchZoom(
                  image: Image(image: imageProvider),
                  zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                  resetDuration: const Duration(milliseconds: 1000),
                  maxScale: 2.5,
                );
              },
              imageUrl: post.url,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      post.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 16.0),
                    Text('by: ' + post.author),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Platform.isAndroid
                            ? IconButton(
                                iconSize: 40.0,
                                onPressed: () async {
                                  await StorageService()
                                      .downloadImage(url: post.url);
                                  await Get.showSnackbar(
                                    GetBar(
                                      duration: const Duration(seconds: 1),
                                      message: 'Image saved successfully',
                                    ),
                                  );
                                  Get.back();
                                },
                                icon: Icon(Icons.file_download),
                              )
                            : const SizedBox(),
                        IconButton(
                          iconSize: 40.0,
                          onPressed: () async {
                            String url =
                                'https://www.reddit.com' + post.permalink;
                            await canLaunch(url)
                                ? await launch(url)
                                : throw 'Could not launch $url';
                          },
                          icon: Icon(Icons.open_in_browser),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
