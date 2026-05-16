import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Helper class for Google Sign-In operations.
///
/// Wraps the google_sign_in package to make it testable and mockable.
class GoogleSignInHelper {
  final GoogleSignIn _googleSignIn;

  GoogleSignInHelper({String? serverClientId, GoogleSignIn? googleSignIn})
    : _googleSignIn = googleSignIn ??
          GoogleSignIn(
            scopes: ['email', 'profile'],
            serverClientId: serverClientId,
            signInOption: SignInOption.standard, // Force account picker
          );

  /// Initiates Google Sign-In flow and returns the ID token.
  ///
  /// Returns null if user cancels the sign-in flow.
  /// Throws [GoogleSignInException] if sign-in fails.
  Future<String?> signIn() async {
    try {
      debugPrint('[GoogleSignIn] Starting sign-in flow...');
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        debugPrint('[GoogleSignIn] User cancelled sign-in');
        return null;
      }

      debugPrint('[GoogleSignIn] Account: ${account.email}');
      final GoogleSignInAuthentication authentication =
          await account.authentication;
      debugPrint(
        '[GoogleSignIn] ID token received: ${authentication.idToken != null ? "yes" : "no"}',
      );
      debugPrint(
        '[GoogleSignIn] Access token received: ${authentication.accessToken != null ? "yes" : "no"}',
      );

      if (authentication.idToken == null) {
        throw GoogleSignInException(
          'No ID token received. Check Google Cloud Console configuration (SHA-1, package name, client ID).',
        );
      }

      return authentication.idToken;
    } catch (e) {
      debugPrint('[GoogleSignIn] Error: $e');
      throw GoogleSignInException('Google Sign-In failed: $e');
    }
  }

  /// Signs out the current Google user.
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}

/// Exception thrown when Google Sign-In fails.
class GoogleSignInException implements Exception {
  final String message;

  GoogleSignInException(this.message);

  @override
  String toString() => message;
}
