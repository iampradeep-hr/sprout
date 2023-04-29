import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tinyhood/firebase/firebaseauth.dart';
import 'package:tinyhood/model/children_model.dart';
import 'package:tinyhood/widgets/child_details_form.dart';

final firebaseAuthData = FutureProvider<String?>((ref) async {
  final service = ref.watch(firebaseAuthProvider);
  return service.getUserName();
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
              elevation: 8,
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
                              fontSize: 15,
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
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Alex",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "John Wick",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "John Wick",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
