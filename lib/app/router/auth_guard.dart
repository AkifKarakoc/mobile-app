import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/application/auth_notifier.dart';

import 'routes.dart';

/// Checks if user is authenticated.
///
/// Reads the current authentication state from [isAuthenticatedProvider].
bool isAuthenticated(Ref ref) {
  return ref.read(isAuthenticatedProvider);
}

/// Returns a redirect path when the requested route is not allowed.
String? authRedirect(BuildContext context, GoRouterState state, Ref ref) {
  final isAuth = isAuthenticated(ref);
  final path = state.uri.path;

  if (!isAuth && _requiresAuth(path)) {
    return AppRoutes.login;
  }

  if (isAuth && _isPublicAuthPath(path)) {
    return AppRoutes.home;
  }

  return null;
}

bool _requiresAuth(String path) {
  return !_isPublicAuthPath(path);
}

bool _isPublicAuthPath(String path) {
  return path == AppRoutes.splash ||
      path == AppRoutes.onboarding ||
      path == AppRoutes.login ||
      path == AppRoutes.register ||
      path == AppRoutes.forgotPassword;
}
