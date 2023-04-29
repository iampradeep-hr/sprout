import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinyhood/firebase/firebaseauth.dart';
import 'package:tinyhood/firebase/firestore.dart';
import 'package:tinyhood/model/children_model.dart';
import 'package:tinyhood/pages/child_profile.dart';
import 'package:tinyhood/pages/milestone_page.dart';
import 'package:tinyhood/widgets/child_details_form.dart';

final firebaseAuthData = FutureProvider<String?>((ref) async {
  final service = ref.watch(firebaseAuthProvider);
  return service.getUserName();
});

final childrenDataProvider = FutureProvider<List<ChildModel>>((ref) async {
  final service = ref.watch(firestoreProvider);
  return service.getChildren();
});

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                            icon: const Icon(Icons.add_rounded))
                      ],
                    ),
                    Consumer(builder: (context, watch, _) {
                      final childrenData = watch.watch(childrenDataProvider);
                      return RefreshIndicator(
                        onRefresh: () async {
                          // Refresh the children's data by calling the Firestore API again
                          await watch.refresh(firestoreProvider).getChildren();
                        },
                        child: childrenData.when(
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
                        ),
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
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right_alt_outlined),
                    iconSize: 45,
                    color: Theme.of(context).colorScheme.primary,
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
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                children: [Text("notifications")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
