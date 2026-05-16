import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/core/utils/snackbar_helper.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_text_field.dart';

/// Forgot password screen for password recovery.
///
/// Displays email input field for password reset flow.
/// TODO: Sprint 8 — Backend endpoint for password reset not yet implemented.
/// Currently shows "coming soon" message when submitted.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // Clear focus
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    // TODO: Sprint 8 — Call actual password reset API
    // For now, show "coming soon" message
    showFloatingSnackBar(
      context,
      'auth.coming_soon'.tr(),
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.forgot_password_title'.tr()),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.lg),

              // Description
              Text(
                'auth.forgot_password_hint'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
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
                textInputAction: TextInputAction.done,
              ),

              const SizedBox(height: AppSpacing.lg),

              // Submit button
              AppButton.primary(
                label: 'auth.forgot_password_submit'.tr(),
                onPressed: _handleSubmit,
                fullWidth: true,
              ),

              const SizedBox(height: AppSpacing.md),

              // Back to login
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
      ),
    );
  }
}
