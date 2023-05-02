import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  bool _isMetric = true; // set default to metric units

  double _bmi = 0;

  void _calculateBmi() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text);

    if (_isMetric) {
      _bmi = weight / (height * height);
    } else {
      _bmi = (weight / (height * height)) * 703;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: _isMetric,
                onChanged: (bool? value) {
                  setState(() {
                    _isMetric = value!;
                  });
                },
              ),
              Text('kg/meter'),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: false,
                groupValue: _isMetric,
                onChanged: (bool? value) {
                  setState(() {
                    _isMetric = value!;
                  });
                },
              ),
              Text('pounds/inches'),
            ],
          ),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: _isMetric ? 'Weight (kg)' : 'Weight (lbs)',
            ),
          ),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: _isMetric ? 'Height (m)' : 'Height (in)',
            ),
          ),
          ElevatedButton(
            child: Text('Calculate'),
            onPressed: _calculateBmi,
          ),
          Text('BMI: ${_bmi.toStringAsFixed(2)}'),
          ElevatedButton(
              onPressed: () {
                launchUrlStart(
                    url:
                        "https://bassammakorvi-autism-appli-xulv2j.streamlit.app/");
              },
              child: Text(
                "Autism Screening test",
                style: TextStyle(
                    fontFamily: "Lexend",
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ))
        ],
      ),
    );
  }
}

Future<void> launchUrlStart({required String url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
