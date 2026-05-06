import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchesStorage {
  RecentSearchesStorage(this._prefs);

  static const storageKey = 'places_recent_searches';
  static const maxRecentSearches = 5;

  final SharedPreferences _prefs;

  Future<List<String>> getRecentSearches() async {
    return List.unmodifiable(_prefs.getStringList(storageKey) ?? const []);
  }

  Future<void> saveQuery(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      return;
    }

    final existingQueries = _prefs.getStringList(storageKey) ?? const [];
    final updatedQueries = <String>[
      trimmedQuery,
      ...existingQueries.where(
        (item) => item.trim().toLowerCase() != trimmedQuery.toLowerCase(),
      ),
    ].take(maxRecentSearches).toList(growable: false);

    await _prefs.setStringList(storageKey, updatedQueries);
  }

  Future<void> clear() async {
    await _prefs.remove(storageKey);
  }
}

final recentSearchesStorageProvider = FutureProvider<RecentSearchesStorage>((
  ref,
) async {
  final prefs = await SharedPreferences.getInstance();
  return RecentSearchesStorage(prefs);
});
