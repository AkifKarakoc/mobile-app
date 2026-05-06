import 'package:dio/dio.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:retrofit/retrofit.dart';

part 'places_api.g.dart';

@RestApi()
abstract class PlacesApi {
  factory PlacesApi(Dio dio, {String baseUrl}) = _PlacesApi;

  @GET('/places/nearby')
  Future<List<PlaceResponse>> getNearby({
    @Query('latitude') required double latitude,
    @Query('longitude') required double longitude,
    @Query('radius') int? radius,
    @Query('limit') int? limit,
    @Query('category') String? category,
  });

  @GET('/places/{id}')
  Future<PlaceDetailResponse> getById(@Path('id') String id);

  @GET('/places/search')
  Future<List<PlaceResponse>> search(@Query('query') String query);
}
