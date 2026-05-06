import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/quests/data/dto/quest_detail_response.dart';
import 'package:mobile/features/quests/data/dto/quest_response.dart';
import 'package:mobile/features/quests/data/dto/verify_step_response.dart';
import 'package:mobile/features/quests/data/quests_repository.dart';

final questsProvider = FutureProvider<List<QuestResponse>>((ref) async {
  final repository = ref.watch(questsRepositoryProvider);
  return repository.getAll();
});

class QuestDetailNotifier
    extends FamilyAsyncNotifier<QuestDetailResponse, String> {
  late QuestsRepository _repository;

  @override
  Future<QuestDetailResponse> build(String arg) async {
    _repository = ref.watch(questsRepositoryProvider);
    return _repository.getById(arg);
  }

  Future<VerifyStepResponse> verifyStep({
    required String stepId,
    MultipartFile? photo,
    required double latitude,
    required double longitude,
  }) async {
    final result = await _repository.verifyStep(
      questId: arg,
      stepId: stepId,
      photo: photo,
      latitude: latitude,
      longitude: longitude,
    );
    ref.invalidateSelf();
    return result;
  }
}

final questDetailProvider =
    AsyncNotifierProvider.family<QuestDetailNotifier, QuestDetailResponse, String>(
      QuestDetailNotifier.new,
    );
