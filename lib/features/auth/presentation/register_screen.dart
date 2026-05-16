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
  late final TextEditingController _phoneCountryCodeController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _birthDateController;
  late final GlobalKey<FormState> _formKey;
  String? _errorMessage;
  DateTime? _selectedBirthDate;
  String _selectedCountryCode = '+90';

  static const List<String> _countryCodes = ['+90', '+1', '+44', '+49', '+33', '+39', '+34', '+7', '+86', '+81', '+91'];

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneCountryCodeController = TextEditingController(text: '+90');
    _phoneNumberController = TextEditingController();
    _birthDateController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneCountryCodeController.dispose();
    _phoneNumberController.dispose();
    _birthDateController.dispose();
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
            phoneCountryCode: _selectedCountryCode,
            phoneNumber: _phoneNumberController.text.trim().isEmpty
                ? null
                : _phoneNumberController.text.trim(),
            birthDate: _selectedBirthDate,
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

    final passwordError = errors['password'];
    if (passwordError != null) {
      if (passwordError.contains('uppercase') ||
          passwordError.contains('lowercase') ||
          passwordError.contains('digit')) {
        return 'auth.error_password_requirements'.tr();
      }
      return passwordError;
    }

    final allErrors = errors.values.toList();
    if (allErrors.isEmpty) {
      return 'common.error_generic'.tr();
    }
    return allErrors.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('auth.register_title'.tr()), elevation: 0),
      body: _buildRegisterForm(isLoading),
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

            // Birth date field
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    _selectedBirthDate = picked;
                    _birthDateController.text =
                        '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                  });
                }
              },
              child: AbsorbPointer(
                child: AppTextField(
                  controller: _birthDateController,
                  label: 'auth.birth_date_label'.tr(),
                  hint: 'auth.birth_date_hint'.tr(),
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Phone fields (country code + number)
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: DropdownButtonFormField<String>(
                    value: _selectedCountryCode,
                    decoration: InputDecoration(
                      labelText: 'auth.country_code_label'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.md,
                      ),
                    ),
                    items: _countryCodes.map((code) {
                      return DropdownMenuItem(value: code, child: Text(code));
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedCountryCode = value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppTextField(
                    controller: _phoneNumberController,
                    label: 'auth.phone_label'.tr(),
                    hint: 'auth.phone_hint'.tr(),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
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

            const SizedBox(height: AppSpacing.sm),

            // Password requirements hint
            Text(
              '• ${'auth.password_hint'.tr()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
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
