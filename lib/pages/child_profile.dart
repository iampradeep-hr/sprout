// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tinyhood/firebase/firebaseauth.dart';
import 'package:tinyhood/firebase/firestore.dart';
import 'package:tinyhood/model/child_vaccine_model.dart';
import 'package:tinyhood/model/children_model.dart';

class ChildProfile extends StatefulWidget {
  final ChildModel childModel;

  const ChildProfile({required this.childModel});

  @override
  State<ChildProfile> createState() => _nameState(childModel);
}

class _nameState extends State<ChildProfile> {
  final ChildModel childModel;

  _nameState(this.childModel);

  @override
  Widget build(BuildContext context) {
    print(childModel);

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final useremail = FirebaseAuth.instance;
                  FirebaseFirestore.instance
                      .collection("userdata")
                      .doc(useremail.toString())
                      .collection("children")
                      .doc(childModel.docId)
                      .delete();

                  Navigator.pop(context);
                },
                child: Icon(Icons.delete),
              ),
            ]),
        body: Container(
          child: Column(
            children: [
              ProfileCard(child: childModel),
              VaccinationReminderWidget()
            ],
          ),
        ));
  }
}

class ProfileCard extends StatelessWidget {
  final ChildModel child;

  ProfileCard({required this.child});

  @override
  Widget build(BuildContext context) {
    MyFirestore firestore = MyFirestore();
    // firestore.getVaccineDetailsOfChild("ck1QaXPXZYr2Nk3toFIK");
    return Column(
      children: [
        Card(
          elevation: 2,
          margin: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Name: ${child.name}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      child.gender == "M" ? Icons.male : Icons.female,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Dob: ${child.dob}",
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.line_weight,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Weight: ${child.birthWeight} kg",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.height,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Height: ${child.birthHeight} cm",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VaccinationReminderWidget extends StatelessWidget {
  MyFirestore firestore = MyFirestore();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: firestore.getVaccinationReminder2(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // show a loading indicator while waiting for data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // show an error message if there's an error
        } else {
          final reminders = snapshot.data ??
              []; // get the data from the snapshot, or an empty list if it's null
          return ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              return Text(
                  reminders[index]); // display each reminder as a text widget
            },
          );
        }
      },
    );
  }
}
