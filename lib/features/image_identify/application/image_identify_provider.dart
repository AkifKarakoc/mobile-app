import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/image_identify/application/tflite_model_service.dart';
import 'package:mobile/features/image_identify/data/dto/image_analysis_response.dart';
import 'package:mobile/features/image_identify/data/image_identify_repository.dart';

class ImageIdentifyNotifier extends AutoDisposeAsyncNotifier<ImageAnalysisResponse?> {
  ImageIdentifyRepository? _repository;
  TfliteModelService? _tfliteService;
  bool _useLocalModel = true;

  @override
  FutureOr<ImageAnalysisResponse?> build() {
    _repository ??= ref.watch(imageIdentifyRepositoryProvider);
    _initTfliteService();
    return null; // Return null initially instead of throwing error
  }

  Future<void> _initTfliteService() async {
    try {
      _tfliteService = TfliteModelService();
      await _tfliteService!.load();
    } catch (e) {
      _useLocalModel = false;
    }
  }

  Future<void> identifyImage({
    required File photoFile,
    required double latitude,
    required double longitude,
  }) async {
    state = const AsyncLoading();
    
    if (_useLocalModel && _tfliteService != null) {
      state = await AsyncValue.guard(() => _identifyWithTflite(photoFile));
    } else {
      state = AsyncValue.error('TFLite modeli yüklenemedi.', StackTrace.current);
    }
  }

  Future<ImageAnalysisResponse> _identifyWithTflite(File photoFile) async {
    final predictions = await _tfliteService!.predict(photoFile);
    if (predictions.isEmpty) throw Exception('Model tahmin yapamadı');

    final bestMatch = predictions.first;
    return ImageAnalysisResponse(
      placeName: bestMatch['label'] as String,
      confidence: (bestMatch['confidence'] as double).clamp(0.0, 1.0),
      description: 'Bu mekan yapay zeka tarafından tespit edilmiştir.',
      imageUrl: '',
    );
  }
}

final imageIdentifyProvider =
    AsyncNotifierProvider.autoDispose<ImageIdentifyNotifier, ImageAnalysisResponse?>(
      ImageIdentifyNotifier.new,
    );
