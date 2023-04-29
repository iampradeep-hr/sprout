import 'package:flutter/material.dart';
import 'package:tinyhood/model/blog_model.dart';

class ExpandableBlogPost extends StatefulWidget {
  final BlogModel blogModel;

  const ExpandableBlogPost({Key? key, required this.blogModel})
      : super(key: key);

  @override
  _ExpandableBlogPostState createState() => _ExpandableBlogPostState();
}

class _ExpandableBlogPostState extends State<ExpandableBlogPost> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Stack(
              children: [
                Image.network(
                  widget.blogModel.imagePath,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      widget.blogModel.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Lexend"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                widget.blogModel.content.replaceAll('\\n', '\n'),
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: "Lexend",
                ),
              ),
            ),
        ],
      ),
    );
  }
}
