import 'package:dio/dio.dart';
import 'package:mobile/features/quests/data/dto/quest_detail_response.dart';
import 'package:mobile/features/quests/data/dto/quest_response.dart';
import 'package:mobile/features/quests/data/dto/user_quest_response.dart';
import 'package:mobile/features/quests/data/dto/verify_step_response.dart';
import 'package:retrofit/retrofit.dart';

part 'quests_api.g.dart';

@RestApi()
abstract class QuestsApi {
  factory QuestsApi(Dio dio, {String baseUrl}) = _QuestsApi;

  @GET('/quests')
  Future<List<QuestResponse>> getAll();

  @GET('/quests/{id}')
  Future<QuestDetailResponse> getById(@Path('id') String id);

  @GET('/quests/user/quests')
  Future<List<UserQuestResponse>> getUserQuests();

  @POST('/quests/{id}/start')
  Future<void> startQuest(@Path('id') String id);

  @POST('/quests/{id}/steps/{stepId}/verify')
  Future<VerifyStepResponse> verifyStep(
    @Path('id') String questId,
    @Path('stepId') String stepId,
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Part(name: 'photo') MultipartFile? photo,
  );
}
