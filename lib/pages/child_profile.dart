import 'package:flutter/material.dart';
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
        ),
        body: Container(
          child: Column(
            children: [
              ProfileCard(child: childModel),
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
    return Card(
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
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
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
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Weight: ${child.birthWeight} kg",
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.height,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Height: ${child.birthHeight} cm",
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
