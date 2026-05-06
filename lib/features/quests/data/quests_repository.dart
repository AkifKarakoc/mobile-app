import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/quests/data/dto/quest_detail_response.dart';
import 'package:mobile/features/quests/data/dto/quest_response.dart';
import 'package:mobile/features/quests/data/dto/user_quest_response.dart';
import 'package:mobile/features/quests/data/dto/verify_step_response.dart';
import 'package:mobile/features/quests/data/quests_api.dart';

abstract class QuestsRepository {
  Future<List<QuestResponse>> getAll();

  Future<QuestDetailResponse> getById(String id);

  Future<List<UserQuestResponse>> getUserQuests();

  Future<void> startQuest(String id);

  Future<VerifyStepResponse> verifyStep({
    required String questId,
    required String stepId,
    MultipartFile? photo,
    required double latitude,
    required double longitude,
  });
}

class QuestsRepositoryImpl implements QuestsRepository {
  QuestsRepositoryImpl(this._api);

  final QuestsApi _api;

  @override
  Future<List<QuestResponse>> getAll() async {
    try {
      return await _api.getAll();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<QuestDetailResponse> getById(String id) async {
    try {
      return await _api.getById(id);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<List<UserQuestResponse>> getUserQuests() async {
    try {
      return await _api.getUserQuests();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<void> startQuest(String id) async {
    try {
      await _api.startQuest(id);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<VerifyStepResponse> verifyStep({
    required String questId,
    required String stepId,
    MultipartFile? photo,
    required double latitude,
    required double longitude,
  }) async {
    try {
      return await _api.verifyStep(
        questId,
        stepId,
        latitude,
        longitude,
        photo,
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final questsRepositoryProvider = Provider<QuestsRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = QuestsApi(dio);
  return QuestsRepositoryImpl(api);
});

ApiException _toApiException(DioException exception) {
  final error = exception.error;
  if (error is ApiException) {
    return error;
  }

  return ApiException.fromDio(exception);
}
