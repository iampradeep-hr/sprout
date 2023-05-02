import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinyhood/model/blog_model.dart';
import 'package:tinyhood/model/child_vaccine_model.dart';
import 'package:tinyhood/model/children_model.dart';
import 'package:tinyhood/model/vaccine_model.dart';

final firestoreProvider = Provider<MyFirestore>((ref) {
  return MyFirestore();
});

final CollectionReference videoRef =
    FirebaseFirestore.instance.collection("youtubevideolinks");

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

  Future<List<String>> getHomePageVideos() async {
    final List<String> videoUrls = [];
    try {
      await videoRef
          .where("appear_on_homepage", isEqualTo: true)
          .get()
          .then((value) {
        for (var e in value.docs) {
          videoUrls.add(e["url"]);
        }
      });
      return videoUrls;
    } catch (e) {
      return videoUrls; // add this line
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

      for (var childSnapshot in childrenList) {
        final docid = childSnapshot.id;
        final childName = childSnapshot.get("name");
        final childGender = childSnapshot.get("gender");
        final childBirthWeight = childSnapshot.get("birthWeight");
        final childBirthHeight = childSnapshot.get("birthHeight");
        final childDob = childSnapshot.get("dob").toDate();

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

  Future<List<String>> getVaccinationReminder() async {
    final List<String> remainders = [];
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final childrenList = <DocumentSnapshot>[];
      final vaccineList = <DocumentSnapshot>[];

      final querySnapshot = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(user!.email)
          .collection('children')
          .orderBy("dob", descending: false)
          .get();
      childrenList.addAll(querySnapshot.docs);

      final querySnapshot2 = await FirebaseFirestore.instance
          .collection("vaccines")
          .orderBy("id", descending: false)
          .get();
      vaccineList.addAll(querySnapshot2.docs);

      for (var childSnapshot in childrenList) {
        final docid = childSnapshot.id;
        final childname = childSnapshot.get("name");
        final childDob = childSnapshot.get('dob').toDate();
        final differenceInDays = DateTime.now().difference(childDob).inDays;
        final vaccinemap = childSnapshot.get("vaccineMap");

        for (var i = 0; i < vaccineList.length; i++) {
          final days = vaccineList[i].get('days');

          int res = days - differenceInDays;
          int res2 = res.abs();
          // // print(res);
          // print("${vaccineList[i].get("days")}");
          // print(vaccinemap[i]);
          if (res2 <= 7) {
            if (vaccinemap[i] == false) {
              remainders.add(
                  '> $childname is due for ${vaccineList[i].get("name")} in $days days.');
              print("$i: ${vaccinemap[i]}");
              // print(
              //     'Reminder: $childname is due for ${vaccineList[i].get("name")} in $days days.');
            }
          }
        }
      }
      return remainders;
    } catch (e) {
      print('Error getting vaccination remainder: $e');
      return [];
    }
  }

  Future<List<String>> getVaccinationReminder2() async {
    final List<String> remainders = [];
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final childrenList = <DocumentSnapshot>[];
      final vaccineList = <DocumentSnapshot>[];

      final querySnapshot = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(user!.email)
          .collection('children')
          .orderBy("dob", descending: false)
          .get();
      childrenList.addAll(querySnapshot.docs);

      final querySnapshot2 = await FirebaseFirestore.instance
          .collection("vaccines")
          .orderBy("id", descending: false)
          .get();
      vaccineList.addAll(querySnapshot2.docs);

      for (var childSnapshot in childrenList) {
        final docid = childSnapshot.id;
        final childname = childSnapshot.get("name");
        final childDob = childSnapshot.get('dob').toDate();
        final differenceInDays = DateTime.now().difference(childDob).inDays;
        final vaccinemap = childSnapshot.get("vaccineMap");
      }
      return remainders;
    } catch (e) {
      print('Error getting vaccination remainder: $e');
      return [];
    }
  }

 
}


