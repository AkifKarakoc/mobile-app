class GoogleOAuthResponse {
  final String accessToken;
  final String refreshToken;
  final String role;
  final bool isNewUser;

  const GoogleOAuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
    this.isNewUser = false,
  });

  factory GoogleOAuthResponse.fromJson(Map<String, dynamic> json) {
    return GoogleOAuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      role: json['role'] as String,
      isNewUser: json['isNewUser'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'role': role,
      'isNewUser': isNewUser,
    };
  }
}
