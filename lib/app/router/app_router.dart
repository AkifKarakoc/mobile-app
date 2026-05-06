import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'auth_guard.dart';
import 'main_shell.dart';
import 'routes.dart';
import 'package:mobile/features/auth/presentation/login_screen.dart';
import 'package:mobile/features/auth/presentation/register_screen.dart';
import 'package:mobile/features/auth/presentation/forgot_password_screen.dart';
import 'package:mobile/features/onboarding/data/onboarding_storage.dart';
import 'package:mobile/features/onboarding/presentation/onboarding_screen.dart'
    as onboarding_feature;
import 'package:mobile/features/home/presentation/home_screen.dart'
    as home_feature;
import 'package:mobile/features/nearby/presentation/nearby_screen.dart'
    as nearby_feature;
import 'package:mobile/features/places/presentation/nearby_map_screen.dart'
    as places_map;
import 'package:mobile/features/places/presentation/place_detail_screen.dart'
    as places_detail;
import 'package:mobile/features/places/presentation/place_search_screen.dart'
    as places_search;
import 'package:mobile/features/user/presentation/favorites_screen.dart'
    as user_favorites;
import 'package:mobile/features/user/presentation/profile_edit_screen.dart'
    as user_profile_edit;
import 'package:mobile/features/user/presentation/profile_screen.dart'
    as user_profile;
import 'package:mobile/features/routes/presentation/routes_list_screen.dart'
    as routes_feature;
import 'package:mobile/features/routes/presentation/route_detail_screen.dart'
    as route_detail_feature;
import 'package:mobile/features/routes/presentation/route_map_screen.dart'
    as route_map_feature;
import 'package:mobile/features/routes/presentation/user_routes_screen.dart'
    as user_routes_feature;
import 'package:mobile/features/quests/presentation/quests_list_screen.dart'
    as quests_feature;
import 'package:mobile/features/quests/presentation/quest_detail_screen.dart'
    as quest_detail_feature;
import 'package:mobile/features/quests/presentation/quest_step_verify_screen.dart'
    as quest_verify_feature;
import 'package:mobile/features/quests/presentation/user_quests_screen.dart'
    as user_quests_feature;
import 'package:mobile/features/image_identify/presentation/image_identify_screen.dart'
    as image_identify_feature;
import 'package:mobile/features/badges/presentation/badges_gallery_screen.dart'
    as badges_feature;
import 'package:mobile/features/chat/presentation/chat_screen.dart'
    as chat_feature;
import 'package:mobile/features/chat/presentation/chat_sessions_screen.dart'
    as chat_sessions_feature;
import 'package:mobile/features/notifications/presentation/notifications_screen.dart'
    as notifications_feature;
import 'package:mobile/features/settings/presentation/settings_screen.dart'
    as settings_feature;
import 'package:mobile/features/todos/presentation/todos_screen.dart'
    as todos_feature;

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) => authRedirect(context, state, ref),
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text(
              'Sayfa bulunamadı',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Ana sayfaya dön'),
            ),
          ],
        ),
      ),
    ),
    routes: [
      // ── Auth & Onboarding ──────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) =>
            const onboarding_feature.OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // ── Main Shell (Bottom Navigation) ────────────────────────
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Tab 0: Home
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const home_feature.HomeScreen(),
          ),

          // Tab 0: Nearby
          GoRoute(
            path: AppRoutes.nearby,
            name: 'nearby',
            builder: (context, state) => const nearby_feature.NearbyScreen(),
            routes: [
              GoRoute(
                path: 'map',
                name: 'nearbyMap',
                builder: (context, state) =>
                    const places_map.NearbyMapScreen(),
              ),
              GoRoute(
                path: 'search',
                name: 'placeSearch',
                builder: (context, state) =>
                    const places_search.PlaceSearchScreen(),
              ),
              GoRoute(
                path: 'place/:id',
                name: 'placeDetail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return places_detail.PlaceDetailScreen(placeId: id);
                },
                routes: [
                  GoRoute(
                    path: 'review-write',
                    name: 'reviewWrite',
                    builder: (context, state) {
                      final placeId = state.pathParameters['id']!;
                      return ReviewWriteScreen(placeId: placeId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Tab 2: Chat & AI (Sprint 6)
          GoRoute(
            path: AppRoutes.chatTab,
            name: 'chatShell',
            builder: (context, state) =>
                const chat_sessions_feature.ChatSessionsScreen(),
            routes: [
              GoRoute(
                path: 'sessions/:sessionId',
                name: 'chatScreen',
                builder: (context, state) {
                  final sessionId = state.pathParameters['sessionId']!;
                  return chat_feature.ChatScreen(sessionId: sessionId);
                },
              ),
            ],
          ),

          // (Favorites accessible from Home screen)
          GoRoute(
            path: AppRoutes.favoritesTab,
            name: 'favorites',
            builder: (context, state) =>
                const user_favorites.FavoritesScreen(),
          ),

          // Tab 3: Profile
          GoRoute(
            path: AppRoutes.profileView,
            name: 'profile',
            builder: (context, state) => const user_profile.ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'profileEdit',
                builder: (context, state) =>
                    const user_profile_edit.ProfileEditScreen(),
              ),
              GoRoute(
                path: 'settings',
                name: 'settings',
                builder: (context, state) =>
                    const settings_feature.SettingsScreen(),
              ),
              GoRoute(
                path: 'notifications',
                name: 'notifications',
                builder: (context, state) =>
                    const notifications_feature.NotificationsScreen(),
              ),
              GoRoute(
                path: 'change-password',
                name: 'changePassword',
                builder: (context, state) => const ChangePasswordScreen(),
              ),
              GoRoute(
                path: 'badges',
                name: 'badges',
                builder: (context, state) => const BadgesScreen(),
              ),
              GoRoute(
                path: 'todos',
                name: 'todos',
                builder: (context, state) => const todos_feature.TodosScreen(),
              ),
              GoRoute(
                path: 'quests',
                name: 'userQuests',
                builder: (context, state) =>
                    const user_quests_feature.UserQuestsScreen(),
              ),
              GoRoute(
                path: 'routes',
                name: 'userRoutes',
                builder: (context, state) =>
                    const user_routes_feature.UserRoutesScreen(),
              ),
            ],
          ),

          // ── Future Sprints (placeholder) ──────────────────────

          // Routes (Sprint 4)
          GoRoute(
            path: '/home/routes',
            name: 'routesShell',
            builder: (context, state) =>
                const routes_feature.RoutesListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'routeDetail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return route_detail_feature.RouteDetailScreen(routeId: id);
                },
                routes: [
                  GoRoute(
                    path: 'map',
                    name: 'routeMap',
                    builder: (context, state) {
                      final routeId = state.pathParameters['id']!;
                      return route_map_feature.RouteMapScreen(routeId: routeId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Quests (Sprint 4)
          GoRoute(
            path: '/home/quests',
            name: 'questsShell',
            builder: (context, state) =>
                const quests_feature.QuestsListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'questDetail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return quest_detail_feature.QuestDetailScreen(questId: id);
                },
                routes: [
                  GoRoute(
                    path: 'steps/:stepId/verify',
                    name: 'questStepVerify',
                    builder: (context, state) {
                      final questId = state.pathParameters['id']!;
                      final stepId = state.pathParameters['stepId']!;
                      return quest_verify_feature.QuestStepVerifyScreen(
                        questId: questId,
                        stepId: stepId,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // ── Image Identify (FAB Access) ──────────────────────────
      GoRoute(
        path: '/image-identify',
        name: 'imageIdentifyFab',
        builder: (context, state) =>
            const image_identify_feature.ImageIdentifyScreen(),
      ),
    ],
  );
});

// ── Splash Screen ────────────────────────────────────────────────

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Fallback: if onboarding provider takes too long, go to login
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        final state = ref.read(isOnboardingCompletedProvider);
        if (state is AsyncLoading) {
          context.go(AppRoutes.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(isOnboardingCompletedProvider, (previous, next) {
      next.when(
        data: (isCompleted) {
          if (!context.mounted) return;
          context.go(isCompleted ? AppRoutes.login : AppRoutes.onboarding);
        },
        error: (error, stackTrace) {
          if (!context.mounted) return;
          debugPrint('Onboarding check failed: $error, going to login');
          context.go(AppRoutes.login);
        },
        loading: () {},
      );
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

// ── Placeholder Screens (Sprint 3+) ─────────────────────────────

class ReviewWriteScreen extends StatelessWidget {
  final String placeId;
  const ReviewWriteScreen({required this.placeId, super.key});

  @override
  Widget build(BuildContext context) =>
      _PlaceholderScreen('Yorum Yaz — placeId: $placeId');
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const _PlaceholderScreen('Şifre Değiştir');
}

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const badges_feature.BadgesGalleryScreen();
}

class _PlaceholderScreen extends StatelessWidget {
  final String label;
  const _PlaceholderScreen(this.label);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IzmirGuide')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction_outlined, size: 48),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
