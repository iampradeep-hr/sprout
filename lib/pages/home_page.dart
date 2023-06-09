import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinyhood/firebase/firebaseauth.dart';
import 'package:tinyhood/firebase/firestore.dart';
import 'package:tinyhood/model/children_model.dart';
import 'package:tinyhood/pages/chat_bot.dart';
import 'package:tinyhood/pages/child_profile.dart';
import 'package:tinyhood/pages/milestone_page.dart';
import 'package:tinyhood/widgets/child_details_form.dart';

final firebaseAuthData = FutureProvider<String?>((ref) async {
  final service = ref.watch(firebaseAuthProvider);
  return service.getUserName();
});

final childrenDataProvider =
    FutureProvider.autoDispose<List<ChildModel>>((ref) async {
  final service = ref.watch(firestoreProvider);
  return service.getChildren();
});

final remainderProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final service = ref.watch(firestoreProvider);
  return service.getVaccinationReminder();
});

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyFirestore firestore = MyFirestore();

  @override
  Widget build(BuildContext context) {
    firestore.getVaccinationReminder();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(
            Icons.message_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatBotPage()));
          }),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final userName = ref.watch(firebaseAuthData);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome ${userName.value ?? "NaN"}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 18,
                          fontFamily: "Lexend"),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Card(
                color: Theme.of(context).colorScheme.onInverseSurface,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tracked Children',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: 20,
                                fontFamily: "Lexend"),
                          ),
                          IconButton(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ChildForm();
                                  },
                                ));
                              },
                              icon: const Icon(
                                Icons.add_box_rounded,
                                color: Colors.redAccent,
                                size: 30,
                              ))
                        ],
                      ),
                      Consumer(builder: (context, watch, _) {
                        final childrenData = watch.watch(childrenDataProvider);
                        return childrenData.when(
                          data: (children) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: children.length,
                              itemBuilder: (context, index) {
                                final child = children[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return ChildProfile(
                                          childModel: children[index],
                                        );
                                      },
                                    ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(4),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          child.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          loading: () => CircularProgressIndicator(),
                          error: (error, stackTrace) => Text('Error: $error'),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 100,
              child: Card(
                color: Theme.of(context).colorScheme.onInverseSurface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Developmental Milestones",
                      style: TextStyle(
                          fontFamily: "Lexend",
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right_alt_outlined),
                      iconSize: 45,
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return TabBarDemo();
                          },
                        ));
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Card(
                color: Theme.of(context).colorScheme.onInverseSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4),
                    bottom: Radius.circular(4),
                  ),
                ),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_active,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Vaccination Reminders",
                        style: TextStyle(
                          fontFamily: "Lexend",
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Consumer(builder: (context, ref, child) {
                      return ref.watch(remainderProvider).when(
                        data: (data) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "$data",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontFamily: "Lexend",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              'Error getting vaccination reminder: $error',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontFamily: "Lexend",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        loading: () {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
