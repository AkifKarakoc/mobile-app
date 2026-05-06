/// Route path constants for the application
abstract final class AppRoutes {
  // Auth & Onboarding
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main tabs (bottom nav roots)
  static const String home = '/home';
  static const String nearby = '/home/nearby';
  static const String nearbyMap = '/home/nearby/map';
  static const String chatTab = '/home/chat';
  static const String favoritesTab = '/home/favorites';
  static const String profileView = '/home/profile';

  // Deprecated: use [nearby] instead
  @Deprecated('Use nearby instead')
  static const String explore = '/home/explore';

  // Explore / Places (Sprint 2)
  static const String placeSearch = '/home/explore/search';
  static const String placeDetail = '/home/explore/place/:id';

  // Place Actions (Sprint 3)
  static const String reviewWrite = '/home/explore/place/:id/review-write';

  // Profile sub-screens
  static const String profileEdit = '/home/profile/edit';
  static const String settings = '/home/profile/settings';
  static const String notifications = '/home/profile/notifications';
  static const String changePassword = '/home/profile/change-password';
  static const String badges = '/home/profile/badges';
  static const String todos = '/home/profile/todos';

  // Routes (Sprint 4)
  static const String routesList = '/home/routes';
  static const String routeDetail = '/home/routes/:id';
  static const String routeMap = '/home/routes/:id/map';
  static const String routePlayer = '/home/routes/:id/player';
  static const String userRoutes = '/home/profile/routes';

  // Quests (Sprint 4-5)
  static const String questsList = '/home/quests';
  static const String questDetail = '/home/quests/:id';
  static const String questStepVerify = '/home/quests/:id/step/:stepId/verify';
  static const String questSuccess = '/home/quests/:id/success';
  static const String userQuests = '/home/profile/quests';

  // Chat & AI (Sprint 6)
  static const String chatSessions = '/home/chat/sessions';
  static const String chatScreen = '/home/chat/sessions/:sessionId';
  static const String imageIdentify = '/home/chat/image-identify';

  // Helpers
  static String placeDetailPath(String placeId) =>
      '/home/explore/place/$placeId';
  static String reviewWritePath(String placeId) =>
      '/home/explore/place/$placeId/review-write';
  static String routeDetailPath(String routeId) => '/home/routes/$routeId';
  static String routeMapPath(String routeId) => '/home/routes/$routeId/map';
  static String routePlayerPath(String routeId) =>
      '/home/routes/$routeId/player';
  static String userRoutesPath() => '/home/profile/routes';
  static String questDetailPath(String questId) => '/home/quests/$questId';
  static String questStepVerifyPath(String questId, String stepId) =>
      '/home/quests/$questId/step/$stepId/verify';
  static String questSuccessPath(String questId) =>
      '/home/quests/$questId/success';
  static String chatScreenPath(String sessionId) =>
      '/home/chat/sessions/$sessionId';

  // Legacy aliases (keep backward compat with existing screens)
  static const String favorites = favoritesTab;
}
