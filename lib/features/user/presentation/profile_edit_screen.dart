import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/user/application/profile_provider.dart';

/// Profile edit screen
class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  String? _selectedAgeGroup;
  String? _selectedLanguage;
  final _formKey = GlobalKey<FormState>();

  static const List<String> _ageGroups = ['18-25', '26-35', '36-50', '50+'];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: Text('profile_edit.title').tr(), centerTitle: true),
      body: profileAsync.when(
        loading: () => const Center(child: AppLoadingIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(profileProvider),
        ),
        data: (user) {
          if (user == null) {
            return Center(child: Text('common.error_generic'.tr()));
          }

          // Initialize form fields on first build
          if (_firstNameController.text.isEmpty) {
            _firstNameController.text = user.firstName;
            _lastNameController.text = user.lastName;
            _phoneController.text = user.phoneNumber ?? '';
            _selectedLanguage = user.preferredLanguage;
            _selectedAgeGroup = user.ageGroup;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // First name
                    AppTextField(
                      label: 'profile_edit.first_name'.tr(),
                      hint: 'profile_edit.first_name'.tr(),
                      controller: _firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'validation.required'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Last name
                    AppTextField(
                      label: 'profile_edit.last_name'.tr(),
                      hint: 'profile_edit.last_name'.tr(),
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'validation.required'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Phone number
                    AppTextField(
                      label: 'profile_edit.phone'.tr(),
                      hint: 'profile_edit.phone'.tr(),
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Age group dropdown
                    _buildDropdown(
                      label: 'profile_edit.age_group'.tr(),
                      value: _selectedAgeGroup,
                      items: _ageGroups,
                      onChanged: (value) {
                        setState(() {
                          _selectedAgeGroup = value;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Language dropdown
                    _buildDropdown(
                      label: 'profile_edit.preferred_language'.tr(),
                      value: _selectedLanguage,
                      items: ['tr', 'en', 'de'],
                      displayItems: ['Türkçe', 'English', 'Deutsch'],
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Save button
                    AppButton.primary(
                      label: 'profile_edit.save'.tr(),
                      onPressed: _handleSave,
                      fullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    List<String>? displayItems,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<String>(
          initialValue: value,
          hint: Text(label),
          items: items.asMap().entries.map((e) {
            return DropdownMenuItem<String>(
              value: e.value,
              child: Text(displayItems?[e.key] ?? e.value),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await ref
          .read(profileProvider.notifier)
          .updateProfile(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            phoneNumber: _phoneController.text.isEmpty
                ? null
                : _phoneController.text,
            ageGroup: _selectedAgeGroup,
            preferredLanguage: _selectedLanguage,
          );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('common.save'.tr())));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}
