import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinyhood/firebase/firestore.dart';
import 'package:tinyhood/model/blog_model.dart';
import '../widgets/blog_post.dart';
import '../widgets/image_slider.dart';

final imagesUrlProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(firestoreProvider);
  return service.getImageSliderUrls();
});
final blogDataProvider = FutureProvider<List<BlogModel>>((ref) async {
  final service = ref.watch(firestoreProvider);
  return service.getBlogData();
});

class TipsPage extends ConsumerWidget {
  MyFirestore f = MyFirestore();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final response = ref.watch(imagesUrlProvider);
    final blogResponse = ref.watch(blogDataProvider);

    return response.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (imagesUrl) => blogResponse.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Text('Error: $error'),
        data: (blogData) => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    imagesUrl: imagesUrl,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Text("Blogs",
                        style: TextStyle(
                            fontFamily: "Lexend",
                            fontSize: 35,
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                  for (var blog in blogData)
                    ExpandableBlogPost(
                      blogModel: BlogModel(
                        blog.title,
                        blog.content.toString(),
                        blog.imagePath,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
