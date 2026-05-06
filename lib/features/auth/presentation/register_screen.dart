import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/auth/application/auth_notifier.dart';

/// Registration screen for new user signup.
///
/// Displays email, password, password confirmation, first name, and last name fields.
/// Validates form and calls the auth notifier to register.
/// On successful registration, navigates to home. On error, shows error message.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final GlobalKey<FormState> _formKey;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    // Clear previous error
    setState(() => _errorMessage = null);

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await ref
          .read(authNotifierProvider.notifier)
          .register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
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
      ValidationException(errors: final errors) => _getValidationErrorMessage(
        errors,
      ),
      NetworkException() => 'common.error_network'.tr(),
      ServerException() => 'common.error_generic'.tr(),
      _ => 'common.error_generic'.tr(),
    };
  }

  String _getValidationErrorMessage(Map<String, String> errors) {
    final emailError = errors['email'];
    if (emailError != null && emailError.contains('already')) {
      return 'auth.error_email_taken'.tr();
    }

    return 'common.error_generic'.tr();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('auth.register_title'.tr()), elevation: 0),
      body: authState.when(
        loading: () => const AppLoadingIndicator(),
        error: (error, stackTrace) => ErrorView(
          message: _getErrorMessage(
            error is ApiException
                ? error
                : ApiException.unknown(error.toString()),
          ),
          onRetry: () => setState(() {}),
        ),
        data: (_) => _buildRegisterForm(isLoading),
      ),
    );
  }

  Widget _buildRegisterForm(bool isLoading) {
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

            // First name field
            AppTextField(
              controller: _firstNameController,
              label: 'auth.first_name_label'.tr(),
              hint: 'auth.first_name_hint'.tr(),
              keyboardType: TextInputType.name,
              validator: (value) {
                final error = Validators.validateName(value);
                if (error != null) {
                  return error.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.md),

            // Last name field
            AppTextField(
              controller: _lastNameController,
              label: 'auth.last_name_label'.tr(),
              hint: 'auth.last_name_hint'.tr(),
              keyboardType: TextInputType.name,
              validator: (value) {
                final error = Validators.validateName(value);
                if (error != null) {
                  return error.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.md),

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
            ),

            const SizedBox(height: AppSpacing.md),

            // Confirm password field
            AppTextField(
              controller: _confirmPasswordController,
              label: 'auth.confirm_password_label'.tr(),
              hint: 'auth.confirm_password_hint'.tr(),
              obscureText: true,
              validator: (value) {
                final error = Validators.validatePasswordMatch(
                  value,
                  _passwordController.text,
                );
                if (error != null) {
                  return error.tr();
                }
                return null;
              },
              textInputAction: TextInputAction.done,
            ),

            const SizedBox(height: AppSpacing.lg),

            // Register button
            AppButton.primary(
              label: 'auth.submit_register'.tr(),
              onPressed: isLoading ? null : _handleRegister,
              isLoading: isLoading,
              fullWidth: true,
            ),

            const SizedBox(height: AppSpacing.md),

            // Sign in link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton.text(
                  label: 'auth.have_account'.tr(),
                  onPressed: () => context.go(AppRoutes.login),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
