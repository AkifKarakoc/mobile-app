import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/quests/data/dto/user_quest_response.dart';
import 'package:mobile/features/quests/data/quests_repository.dart';

final userQuestsProvider = FutureProvider<List<UserQuestResponse>>((ref) async {
  final repository = ref.watch(questsRepositoryProvider);
  return repository.getUserQuests();
});

class StartQuestNotifier extends FamilyAsyncNotifier<void, String> {
  QuestsRepository? _repository;

  @override
  Future<void> build(String arg) async {
    _repository ??= ref.watch(questsRepositoryProvider);
  }

  Future<void> start() async {
    await _repository!.startQuest(arg);
    ref.invalidate(userQuestsProvider);
  }
}

final startQuestProvider =
    AsyncNotifierProvider.family<StartQuestNotifier, void, String>(
      StartQuestNotifier.new,
    );
