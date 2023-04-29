import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinyhood/model/blog_model.dart';
import 'package:tinyhood/model/children_model.dart';
import 'package:tinyhood/model/vaccine_model.dart';

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

  Future<List<ChildModel>> getChildren() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      List<DocumentSnapshot> childrenList = [];
      List<ChildModel> childrenData = [];

      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(user!.email)
          .collection("children")
          .get();

      childrenList = querySnapshot.docs;

// Now you can use the childrenList as needed, such as iterating over the documents and accessing their data:
      // Now you can use the childrenList as needed, such as iterating over the documents and accessing their data:
      for (var childSnapshot in childrenList) {
        final docid = childSnapshot.id;
        final childName = childSnapshot.get("name");
        final childGender = childSnapshot.get("gender");
        final childBirthWeight = childSnapshot.get("birthWeight");
        final childBirthHeight = childSnapshot.get("birthHeight");
        final childDob = childSnapshot.get("dob").toDate();

        // Calculate the difference between today's date and the child's dob
        final differenceInDays = DateTime.now().difference(childDob).inDays;

        childrenData.add(ChildModel(
            docId: docid,
            birthHeight: childBirthHeight,
            birthWeight: childBirthWeight,
            gender: childGender,
            name: childName,
            dob: childDob.toString()));
      }
      return childrenData;
    } catch (e) {
      print("Error getting blog data: $e");
      return [];
    }
  }

  void getVaccinationRemainder() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      List<DocumentSnapshot> childrenList = [];
      List<DocumentSnapshot> vaccineList = [];

      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(user!.email)
          .collection("children")
          .get();

      childrenList = querySnapshot.docs;

      for (var childSnapshot in childrenList) {
        final docid = childSnapshot.id;
        final childDob = childSnapshot.get("dob").toDate();

        // Calculate the difference between today's date and the child's dob
        final differenceInDays = DateTime.now().difference(childDob).inDays;
        print(" difference in dob and today: $differenceInDays");
      }

      final QuerySnapshot querySnapshot2 =
          await FirebaseFirestore.instance.collection('vaccines').get();
      vaccineList = querySnapshot2.docs;
      for (var vaccine in vaccineList) {
        final days = vaccine.get("days");
        print("when to be taken: $days");
      }
    } catch (e) {
      print("Error getting blog data: $e");
    }
  }
}
