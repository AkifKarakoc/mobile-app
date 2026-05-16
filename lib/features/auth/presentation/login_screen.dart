import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/env/env_provider.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/features/auth/application/auth_notifier.dart';
import 'package:mobile/features/auth/presentation/google_sign_in_helper.dart';

/// Login screen for user authentication.
///
/// Displays email and password input fields, validates form, and calls the auth notifier.
/// On successful login, navigates to home. On error, shows error message.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;
  String? _errorMessage;
  bool _isGoogleSigningIn = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _errorMessage = null;
      _isGoogleSigningIn = true;
    });

    try {
      final googleClientId = ref.read(envProvider).googleClientId;
      final helper = GoogleSignInHelper(serverClientId: googleClientId);
      final idToken = await helper.signIn();

      if (idToken == null) {
        // User cancelled
        setState(() => _isGoogleSigningIn = false);
        return;
      }

      await ref
          .read(authNotifierProvider.notifier)
          .loginWithGoogle(idToken: idToken);

      if (mounted) {
        context.go(AppRoutes.home);
      }
    } on ApiException catch (e) {
      setState(() => _errorMessage = _getErrorMessage(e));
    } catch (e) {
      setState(() => _errorMessage = 'error_generic'.tr());
    } finally {
      if (mounted) {
        setState(() => _isGoogleSigningIn = false);
      }
    }
  }

  Future<void> _handleLogin() async {
    // Clear previous error
    setState(() => _errorMessage = null);

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await ref
          .read(authNotifierProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      // On success, navigate to home
      if (mounted) {
        context.go(AppRoutes.home);
      }
    } on ApiException catch (e) {
      // Handle specific API exceptions
      String errorMsg = _getErrorMessage(e);
      setState(() => _errorMessage = errorMsg);
    } catch (e) {
      setState(() => _errorMessage = 'error_generic'.tr());
    }
  }

  String _getErrorMessage(ApiException exception) {
    return switch (exception) {
      UnauthorizedException() => 'auth.error_invalid_credentials'.tr(),
      NetworkException() => 'common.error_network'.tr(),
      ServerException() => 'common.error_generic'.tr(),
      _ => 'common.error_generic'.tr(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('auth.login_title'.tr()), elevation: 0),
      body: _buildLoginForm(isLoading),
    );
  }

  Widget _buildLoginForm(bool isLoading) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.lg),

            // Error message
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Text(
                  _errorMessage!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),

            const SizedBox(height: AppSpacing.lg),

            // Email field
            AppTextField(
              controller: _emailController,
              label: 'auth.email_label'.tr(),
              hint: 'auth.email_hint'.tr(),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final error = Validators.validateEmail(value);
                if (error != null) {
                  return error.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.md),

            // Password field
            AppTextField(
              controller: _passwordController,
              label: 'auth.password_label'.tr(),
              hint: 'auth.password_hint'.tr(),
              obscureText: true,
              validator: (value) {
                final error = Validators.validatePassword(value);
                if (error != null) {
                  return error.tr();
                }
                return null;
              },
              textInputAction: TextInputAction.done,
            ),

            const SizedBox(height: AppSpacing.md),

            // Forgot password link
            Align(
              alignment: Alignment.centerRight,
              child: AppButton.text(
                label: 'auth.forgot_password'.tr(),
                onPressed: () => context.push(AppRoutes.forgotPassword),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Login button
            AppButton.primary(
              label: 'auth.submit_login'.tr(),
              onPressed: isLoading ? null : _handleLogin,
              isLoading: isLoading,
              fullWidth: true,
            ),

            const SizedBox(height: AppSpacing.md),

            // Divider with "or" text
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text('auth.or'.tr()),
                ),
                const Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Google Sign-In button
            AppButton.secondary(
              label: 'auth.continue_with_google'.tr(),
              onPressed: _isGoogleSigningIn ? null : _handleGoogleSignIn,
              isLoading: _isGoogleSigningIn,
              fullWidth: true,
              icon: Icons.login,
            ),

            const SizedBox(height: AppSpacing.md),

            // Sign up link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton.text(
                  label: 'auth.no_account'.tr(),
                  onPressed: () => context.go(AppRoutes.register),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
