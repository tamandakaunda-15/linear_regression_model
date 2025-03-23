import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diabetes Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 245, 163, 197),
        textTheme: GoogleFonts.poppinsTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Predictor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Diabetes Predictor',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This app helps predict diabetes risk based on medical data',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PredictionPage()),
                );
              },
              child: const Text('Start Prediction'),
            ),
          ],
        ),
      ),
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key}) : super(key: key);

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for text fields
  final pregnanciesController = TextEditingController();
  final glucoseController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final skinThicknessController = TextEditingController();
  final insulinController = TextEditingController();
  final bmiController = TextEditingController();
  final diabetesPedigreeController = TextEditingController();
  final ageController = TextEditingController();
  
  String _predictionResult = '';
  bool _isLoading = false;

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    pregnanciesController.dispose();
    glucoseController.dispose();
    bloodPressureController.dispose();
    skinThicknessController.dispose();
    insulinController.dispose();
    bmiController.dispose();
    diabetesPedigreeController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _predict() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _predictionResult = '';
      });

      // Prepare data for API request
      final data = {
        'pregnancies': int.parse(pregnanciesController.text),
        'glucose': double.parse(glucoseController.text),
        'blood_pressure': double.parse(bloodPressureController.text),
        'skin_thickness': double.parse(skinThicknessController.text),
        'insulin': double.parse(insulinController.text),
        'bmi': double.parse(bmiController.text),
        'diabetes_pedigree': double.parse(diabetesPedigreeController.text),
        'age': int.parse(ageController.text),
      };

      try {
        // Replace with your actual API endpoint
        final response = await http.post(
          Uri.parse('http://localhost:8000/predict'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          setState(() {
            _predictionResult = result['message'];
            if (result['prediction'] == 1) {
              _predictionResult += '\n\nProbability: ${(result['probability'] * 100).toStringAsFixed(2)}%';
            }
          });
        } else {
          setState(() {
            _predictionResult = 'Error: ${response.statusCode}\n${response.body}';
          });
        }
      } catch (e) {
        setState(() {
          _predictionResult = 'Error: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Medical Data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              
              // Pregnancies
              TextFormField(
                controller: pregnanciesController,
                decoration: const InputDecoration(
                  labelText: 'Number of Pregnancies',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 43, 2, 30)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 0 || number > 20) {
                    return 'Value must be between 0 and 20';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Glucose
              TextFormField(
                controller: glucoseController,
                decoration: const InputDecoration(
                  labelText: 'Glucose Level (mg/dL)',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 34, 2, 24)),
          
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 0 || number > 300) {
                    return 'Value must be between 0 and 300';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Blood Pressure
              TextFormField(
                controller: bloodPressureController,
                decoration: const InputDecoration(
                  labelText: 'Blood Pressure (mm Hg)',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 37, 1, 31)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 0 || number > 200) {
                    return 'Value must be between 0 and 200';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Skin Thickness
              TextFormField(
                controller: skinThicknessController,
                decoration: const InputDecoration(
                  labelText: 'Skin Thickness (mm)',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 41, 1, 27)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 0 || number > 100) {
                    return 'Value must be between 0 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Insulin
              TextFormField(
                controller: insulinController,
                decoration: const InputDecoration(
                  labelText: 'Insulin Level (mu U/ml)',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 36, 2, 18)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 0 || number > 1000) {
                    return 'Value must be between 0 and 1000';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // BMI
              TextFormField(
                controller: bmiController,
                decoration: const InputDecoration(
                  labelText: 'BMI',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 48, 1, 27)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 0 || number > 70) {
                    return 'Value must be between 0 and 70';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Diabetes Pedigree
              TextFormField(
                controller: diabetesPedigreeController,
                decoration: const InputDecoration(
                  labelText: 'Diabetes Pedigree Function',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 41, 2, 17)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 0 || number > 3) {
                    return 'Value must be between 0 and 3';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Age
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age (years)',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 44, 2, 26)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  if (number < 0 || number > 100) {
                    return 'Value must be between 0 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Predict Button
              ElevatedButton(
                onPressed: _isLoading ? null : _predict,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Color.fromARGB(255, 114, 2, 80))
                    : const Text('Predict'),
              ),
              const SizedBox(height: 20),
              
              // Prediction Result
              if (_predictionResult.isNotEmpty) ...[
                const Text(
                  'Prediction Result',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  _predictionResult,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18,
                    color: Color.fromARGB(255, 114, 2, 80),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',)
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
