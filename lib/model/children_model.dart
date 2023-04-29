import 'package:cloud_firestore/cloud_firestore.dart';

class ChildModel {
  final String child_name;
  final Timestamp child_added_on;
  final Timestamp child_dob;

  ChildModel(this.child_name, this.child_added_on, this.child_dob);

  
}
