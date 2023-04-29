import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tinyhood/firebase/firebaseauth.dart';
import 'package:tinyhood/model/blog_model.dart';
import 'package:tinyhood/model/children_model.dart';

final firestoreProvider = Provider<MyFirestore>((ref) {
  return MyFirestore();
});

class MyFirestore {
  final CollectionReference projectsRef =
      FirebaseFirestore.instance.collection("facts");
  final CollectionReference blogRef =
      FirebaseFirestore.instance.collection("blog");

  Future<List<String>> getImageSliderUrls() async {
    try {
      final List<String> imagesUrl = [];
      final value = await projectsRef.doc("slider_images").get();
      final imagesData = value.get("url");

      for (var i in imagesData) {
        imagesUrl.add(i);
      }

      return imagesUrl;
    } catch (e) {
      print("Error getting images: $e");
      return [];
    }
  }

  Future<List<BlogModel>> getBlogData() async {
    try {
      final List<BlogModel> blogs = [];
      final value = await blogRef.get().then((value) {
        for (var i in value.docs) {
          blogs.add(BlogModel(
            i.get("title"),
            i.get("content"),
            i.get("imageurl"),
          ));
        }

        return blogs;
      });

      return value;
    } catch (e) {
      print("Error getting blog data: $e");
      return [];
    }
  }

  // Future<List<ChildModel>> getChildren() async {
  //   try {
  //     String? useremail = GoogleSignIn().currentUser?.email;
  //     if(useremail!=null){
        
  //     }
  //     final List<BlogModel> blogs = [];
  //     final value = await blogRef.get().then((value) {
  //       for (var i in value.docs) {
  //         blogs.add(BlogModel(
  //           i.get("title"),
  //           i.get("content"),
  //           i.get("imageurl"),
  //         ));
  //       }

  //       return blogs;
  //     });
  //   } catch (e) {
  //     print("Error getting blog data: $e");
  //     return [];
  //   }
  // }
}
