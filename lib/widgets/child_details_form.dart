import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class ChildForm extends StatefulWidget {
  @override
  _ChildFormState createState() => _ChildFormState();
}

class _ChildFormState extends State<ChildForm> {
  // Get the currently signed-in user
  final user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthWeightController = TextEditingController();
  final TextEditingController _birthHeightController = TextEditingController();

  DateTime? _dob;

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _birthWeightController.dispose();
    _birthHeightController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Save the data to Firestore or any other database
      final childName = _nameController.text.trim();
      final childGender = _genderController.text.trim();
      final childBirthWeight = _birthWeightController.text.trim();
      final childBirthHeight = _birthHeightController.text.trim();

      print('Child Name: $childName');
      print('Child Gender: $childGender');
      print('Child Birth Weight: $childBirthWeight');
      print('Child Birth Height: $childBirthHeight');
      print('Child DOB: $_dob');

      // Add the data to Firestore
      final res = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(user!.email)
          .collection("children")
          .add({
        'name': childName,
        'gender': childGender,
        'birthWeight': childBirthWeight,
        'birthHeight': childBirthHeight,
        'dob': _dob,
        // Add the user's email to the document
      });

      if (res != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$childName was added successfully.'),
          ),
        );
      }

      // Clear the form fields
      _nameController.clear();
      _genderController.clear();
      _birthWeightController.clear();
      _birthHeightController.clear();
      setState(() {
        _dob = null;
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Enter your child details',
            style: TextStyle(
                fontFamily: "Lexend",
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Child Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter child name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      labelText: 'Gender[M/F]',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter gender';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _birthWeightController,
                    decoration: InputDecoration(
                      labelText: 'Birth Weight in kg',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter birth weight';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _birthHeightController,
                    decoration: InputDecoration(
                      labelText: 'Birth Height in cm',
                      hintStyle: TextStyle(
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter birth height';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _dob =
                              DateTime(picked.year, picked.month, picked.day);
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'DOB',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: Text(
                        _dob == null
                            ? 'Please select a date'
                            : DateFormat('dd MMMM yyyy').format(_dob!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: "Lexend",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

 
}
