import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinyhood/firebase/firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final videoUrlsFutureProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(firestoreProvider);

  return service.getHomePageVideos();
});

class VideoGridView extends ConsumerWidget {
  VideoGridView({Key? key}) : super(key: key);

  String getViewID(int index) {
    return 'view-$index';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoUrlsAsyncValue = ref.watch(videoUrlsFutureProvider);

    return videoUrlsAsyncValue.when(
        data: (videoUrls) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: videoUrls.length,
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId:
                        YoutubePlayer.convertUrlToId(videoUrls[index])!,
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                ),
              );
            },
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => const Text('Something Went Wrong!'));
  }
}
