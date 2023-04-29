import 'package:flutter/material.dart';
import 'package:tinyhood/widgets/community_form.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            child: Text("Settings"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommunityForumScreen(),
                    ));
              },
              child: Text("click"))
        ],
      ),
    );
  }
}
