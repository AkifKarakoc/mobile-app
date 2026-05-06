import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mobile/features/auth/data/dto/register_request.dart';
import 'package:mobile/features/auth/data/dto/register_response.dart';
import 'package:mobile/features/auth/data/dto/login_request.dart';
import 'package:mobile/features/auth/data/dto/login_response.dart';
import 'package:mobile/features/auth/data/dto/refresh_request.dart';
import 'package:mobile/features/auth/data/dto/refresh_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/auth/refresh')
  Future<RefreshResponse> refresh(@Body() RefreshRequest request);

  @POST('/auth/logout')
  Future<void> logout();
}
