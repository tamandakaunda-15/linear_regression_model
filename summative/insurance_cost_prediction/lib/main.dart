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
      title: 'Medical Insurance Predictor',
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
        title: const Text('Medical Insurance Predictor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Medical Insurance Predictor',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This app helps predict your medical insurance eligibility based on medical data',
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
  
  final ageController = TextEditingController();
  final bmiController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final cholesterolController = TextEditingController();
  final smokingController = TextEditingController();
  final exerciseController = TextEditingController();
  final familyHistoryController = TextEditingController();

  String _predictionResult = '';
  bool _isLoading = false;

  @override
  void dispose() {
    ageController.dispose();
    bmiController.dispose();
    bloodPressureController.dispose();
    cholesterolController.dispose();
    smokingController.dispose();
    exerciseController.dispose();
    familyHistoryController.dispose();
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
        'age': int.parse(ageController.text),
        'bmi': double.parse(bmiController.text),
        'blood_pressure': double.parse(bloodPressureController.text),
        'cholesterol': double.parse(cholesterolController.text),
        'smoking': smokingController.text.toLowerCase() == 'yes' ? 1 : 0,
        'exercise': exerciseController.text.toLowerCase() == 'yes' ? 1 : 0,
        'family_history': familyHistoryController.text.toLowerCase() == 'yes' ? 1 : 0,
      };

      try {
        // API endpoint for medical insurance prediction
        final response = await http.post(
          Uri.parse('https://medical-insurance-predictor-44bt.onrender.com/predict'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          setState(() {
            _predictionResult = result['message'];
            if (result['prediction'] == 1) {
              _predictionResult += '\n\nEligibility: Eligible for insurance';
            } else {
              _predictionResult += '\n\nEligibility: Not eligible for insurance';
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
        title: const Text('Medical Insurance Prediction'),
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
              
              // Age
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age (years)',
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
                  if (number < 18 || number > 100) {
                    return 'Age must be between 18 and 100';
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
              
              // Blood Pressure
              TextFormField(
                controller: bloodPressureController,
                decoration: const InputDecoration(
                  labelText: 'Blood Pressure (mm Hg)',
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
              
              // Cholesterol
              TextFormField(
                controller: cholesterolController,
                decoration: const InputDecoration(
                  labelText: 'Cholesterol (mg/dL)',
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
                  if (number < 0 || number > 400) {
                    return 'Value must be between 0 and 400';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Smoking
              TextFormField(
                controller: smokingController,
                decoration: const InputDecoration(
                  labelText: 'Do you smoke? (yes/no)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please answer this question';
                  }
                  if (value.toLowerCase() != 'yes' && value.toLowerCase() != 'no') {
                    return 'Please enter yes or no';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Exercise
              TextFormField(
                controller: exerciseController,
                decoration: const InputDecoration(
                  labelText: 'Do you exercise regularly? (yes/no)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please answer this question';
                  }
                  if (value.toLowerCase() != 'yes' && value.toLowerCase() != 'no') {
                    return 'Please enter yes or no';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Family History
              TextFormField(
                controller: familyHistoryController,
                decoration: const InputDecoration(
                  labelText: 'Family History of Medical Issues? (yes/no)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please answer this question';
                  }
                  if (value.toLowerCase() != 'yes' && value.toLowerCase() != 'no') {
                    return 'Please enter yes or no';
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
                    color: Color.fromARGB(255, 119, 4, 81),
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
