import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CareerPredictor {
  late Interpreter _interpreter;
  late List<String> _featureColumns;
  late List<double> _scalerMean;
  late List<double> _scalerScale;
  late List<String> _jobTitles;

  Future<void> loadModel() async {
    // Load TFLite model
    _interpreter = await Interpreter.fromAsset('career_model.tflite');

    // Load metadata JSON
    final metadataStr = await rootBundle.loadString('assets/feature_metadata.json');
    final metadata = jsonDecode(metadataStr);
    _featureColumns = List<String>.from(metadata['columns']);
    _scalerMean = List<double>.from(metadata['scaler_mean']);
    _scalerScale = List<double>.from(metadata['scaler_scale']);
    _jobTitles = List<String>.from(metadata['job_titles']);
  }

  /// Make a prediction from input data
  String predict(Map<String, dynamic> userInput) {
    final inputVector = _preprocess(userInput);
    final inputTensor = Float32List.fromList(inputVector).reshape([1, inputVector.length]);

    final outputTensor = List.filled(_jobTitles.length, 0.0).reshape([1, _jobTitles.length]);

    _interpreter.run(inputTensor, outputTensor);

    final output = outputTensor[0];
    final maxIndex = output.indexWhere((v) => v == output.reduce((a, b) => a > b ? a : b));

    return _jobTitles[maxIndex];
  }

  /// Manual preprocessing (encoding + feature engineering + scaling)
  List<double> _preprocess(Map<String, dynamic> input) {
    // RIASEC binary encoding
    const riasecOrder = ['R', 'I', 'A', 'S', 'E', 'C'];
    final riasecVector = riasecOrder.map((code) => input['RIASEC'].contains(code) ? 1.0 : 0.0).toList();

    // Base features
    final o = input['Big_Five_O'] * 1.0;
    final c = input['Big_Five_C'] * 1.0;
    final e = input['Big_Five_E'] * 1.0;
    final a = input['Big_Five_A'] * 1.0;
    final n = input['Big_Five_N'] * 1.0;
    final ps = input['Problem_Solving'] * 1.0;
    final ct = input['Critical_Thinking'] * 1.0;

    final bigFive = [o, c, e, a, n];
    final bigFiveSum = bigFive.reduce((a, b) => a + b);
    final bigFiveMean = bigFiveSum / bigFive.length;
    final interaction = ps * ct;

    // Polynomial interaction terms (degree=2, interaction only)
    final polyFeatures = <double>[];
    for (int i = 0; i < bigFive.length; i++) {
      for (int j = i + 1; j < bigFive.length; j++) {
        polyFeatures.add(bigFive[i] * bigFive[j]);
      }
    }

    // Combine features
    final rawFeatures = [
      ...riasecVector,
      ps,
      ct,
      bigFiveSum,
      bigFiveMean,
      interaction,
      ...polyFeatures
    ];

    // Standardization (z-score)
    final scaled = List<double>.generate(
      rawFeatures.length,
          (i) => (rawFeatures[i] - _scalerMean[i]) / _scalerScale[i],
    );

    return scaled;
    }
}
