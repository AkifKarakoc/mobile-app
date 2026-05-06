/// Form field validators for auth and other screens
abstract final class Validators {
  /// Validates email format.
  ///
  /// Returns error message if invalid, null if valid.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.validation_email_required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'auth.validation_email_invalid';
    }

    return null;
  }

  /// Validates password strength.
  ///
  /// Requires at least 8 characters.
  /// Returns error message if invalid, null if valid.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.validation_password_required';
    }

    if (value.length < 8) {
      return 'auth.validation_password_min';
    }

    return null;
  }

  /// Validates that password fields match.
  ///
  /// Used for password confirmation on registration.
  static String? validatePasswordMatch(
    String? value,
    String? originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'auth.validation_password_required';
    }

    if (value != originalPassword) {
      return 'auth.validation_password_mismatch';
    }

    return null;
  }

  /// Validates name field (non-empty, at least 2 characters).
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.validation_name_required';
    }

    if (value.length < 2) {
      return 'auth.validation_name_min';
    }

    return null;
  }

  /// Validates that field is not empty.
  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.validation_required';
    }

    return null;
  }
}
