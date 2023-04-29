import 'package:flutter/material.dart';

class MyImageLoader extends StatelessWidget {
  final String imageUrl;

  const MyImageLoader({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(imageUrl), context);

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
