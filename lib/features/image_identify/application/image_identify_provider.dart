import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/image_identify/data/dto/image_analysis_response.dart';
import 'package:mobile/features/image_identify/data/image_identify_repository.dart';

class ImageIdentifyNotifier extends AutoDisposeAsyncNotifier<ImageAnalysisResponse?> {
  ImageIdentifyRepository? _repository;

  @override
  FutureOr<ImageAnalysisResponse?> build() {
    _repository ??= ref.watch(imageIdentifyRepositoryProvider);
    return null;
  }

  Future<void> identifyImage({
    required File photoFile,
    required double latitude,
    required double longitude,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final photo = await MultipartFile.fromFile(photoFile.path);
      return _repository!.identifyImage(
        photo: photo,
        latitude: latitude,
        longitude: longitude,
      );
    });
  }
}

final imageIdentifyProvider =
    AsyncNotifierProvider.autoDispose<ImageIdentifyNotifier, ImageAnalysisResponse?>(
  ImageIdentifyNotifier.new,
);
