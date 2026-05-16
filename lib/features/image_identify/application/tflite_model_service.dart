import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class TfliteModelService {
  late Interpreter _interpreter;
  late List<String> _labels;

  final int inputSize;
  final String modelPath;
  final String labelsPath;

  TfliteModelService({
    this.inputSize = 224,
    this.modelPath = 'assets/models/izmir_mekan_model.tflite',
    this.labelsPath = 'assets/models/labels.txt',
  });

  Future<void> load() async {
    // Emulators often fail with GPU delegate. Force CPU usage.
    final options = InterpreterOptions()..threads = 1;
    _interpreter = await Interpreter.fromAsset(modelPath, options: options);
    
    final labelsContent = await rootBundle.loadString(labelsPath);
    _labels = labelsContent
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  Future<List<Map<String, dynamic>>> predict(
    File imageFile, {
    int topK = 3,
  }) async {
    final input = await _preprocessImage(imageFile);
    final outputShape = _interpreter.getOutputTensor(0).shape;
    
    // Handle 2D output shape [1, numClasses]
    final output = List.generate(
      outputShape[0],
      (_) => List.filled(outputShape[1], 0.0),
    );

    _interpreter.run(input, output);
    
    // Flatten the 2D output to 1D for processing
    final flatOutput = output.expand((row) => row).toList();
    final results = _processOutput(flatOutput);

    results.sort((a, b) => b['confidence'].compareTo(a['confidence']));
    return results.take(topK).toList();
  }

  Future<List<List<List<List<double>>>>> _preprocessImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) throw Exception('Görsel okunamadı');

    final resized = img.copyResize(
      image,
      width: inputSize,
      height: inputSize,
      interpolation: img.Interpolation.linear,
    );

    final input = List.generate(1, (_) =>
      List.generate(inputSize, (y) =>
        List.generate(inputSize, (x) {
          final pixel = resized.getPixel(x, y);
          return [
            pixel.r / 255.0,
            pixel.g / 255.0,
            pixel.b / 255.0,
          ];
        }),
      ),
    );
    return input;
  }

  List<Map<String, dynamic>> _processOutput(List<double> output) {
    final results = <Map<String, dynamic>>[];
    for (var i = 0; i < output.length; i++) {
      final confidence = output[i];
      if (confidence > 0.0) {
        results.add({
          'index': i,
          'label': i < _labels.length ? _labels[i] : 'Bilinmeyen',
          'confidence': confidence,
        });
      }
    }
    return results;
  }

  void dispose() {
    _interpreter.close();
  }
}
