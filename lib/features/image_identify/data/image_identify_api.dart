import 'package:dio/dio.dart';
import 'package:mobile/features/image_identify/data/dto/image_analysis_response.dart';
import 'package:retrofit/retrofit.dart';

part 'image_identify_api.g.dart';

@RestApi()
abstract class ImageIdentifyApi {
  factory ImageIdentifyApi(Dio dio, {String baseUrl}) = _ImageIdentifyApi;

  @POST('/images/identify')
  Future<ImageAnalysisResponse> identifyImage(
    @Part(name: 'photo') MultipartFile photo,
    @Part(name: 'latitude') double latitude,
    @Part(name: 'longitude') double longitude,
  );
}
