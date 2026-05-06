import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/image_identify/data/dto/image_analysis_response.dart';
import 'package:mobile/features/image_identify/data/image_identify_api.dart';

abstract class ImageIdentifyRepository {
  Future<ImageAnalysisResponse> identifyImage({
    required MultipartFile photo,
    required double latitude,
    required double longitude,
  });
}

class ImageIdentifyRepositoryImpl implements ImageIdentifyRepository {
  ImageIdentifyRepositoryImpl(this._api);

  final ImageIdentifyApi _api;

  @override
  Future<ImageAnalysisResponse> identifyImage({
    required MultipartFile photo,
    required double latitude,
    required double longitude,
  }) async {
    try {
      return await _api.identifyImage(photo, latitude, longitude);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final imageIdentifyRepositoryProvider = Provider<ImageIdentifyRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = ImageIdentifyApi(dio);
  return ImageIdentifyRepositoryImpl(api);
});

ApiException _toApiException(DioException exception) {
  final error = exception.error;
  if (error is ApiException) {
    return error;
  }

  return ApiException.fromDio(exception);
}
