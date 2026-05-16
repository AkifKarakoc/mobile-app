import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/snackbar_helper.dart';
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
  late TextEditingController _birthDateController;
  String? _selectedLanguage;
  String? _selectedCountryCode;
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedBirthDate;
  File? _selectedPhoto;
  bool _isUploadingPhoto = false;
  String? _lastLoadedUserId; // Track which user's data is loaded

  static const List<String> _countryCodes = [
    '+90',
    '+1',
    '+44',
    '+49',
    '+33',
    '+39',
    '+34',
    '+7',
    '+86',
    '+81',
    '+91',
  ];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _birthDateController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
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
            return Center(child: Text('common.error_generic').tr());
          }

          // Update form fields whenever user data changes (e.g., after login or refresh)
          if (_lastLoadedUserId != user.id) {
            _lastLoadedUserId = user.id;
            _firstNameController.text = user.firstName;
            _lastNameController.text = user.lastName;
            _phoneController.text = user.phoneNumber ?? '';
            _selectedLanguage = user.preferredLanguage;
            _selectedCountryCode = user.phoneCountryCode ?? '+90';
            _selectedBirthDate = user.birthDate;
            if (user.birthDate != null) {
              final bd = user.birthDate!;
              _birthDateController.text =
                  '${bd.day.toString().padLeft(2, '0')}/${bd.month.toString().padLeft(2, '0')}/${bd.year}';
            }
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Profile photo upload
                    _buildPhotoUploadSection(context, user),
                    const SizedBox(height: AppSpacing.lg),

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

                    // Phone fields (country code + number)
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: DropdownButtonFormField<String>(
                            value: _selectedCountryCode,
                            decoration: InputDecoration(
                              labelText: 'profile_edit.country_code'.tr(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.md,
                              ),
                            ),
                            items: _countryCodes.map((code) {
                              return DropdownMenuItem(
                                value: code,
                                child: Text(code),
                              );
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
                            label: 'profile_edit.phone'.tr(),
                            hint: 'profile_edit.phone'.tr(),
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Birth date picker
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedBirthDate ?? DateTime(2000),
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
                          label: 'profile_edit.birth_date'.tr(),
                          hint: 'profile_edit.birth_date_hint'.tr(),
                          controller: _birthDateController,
                          readOnly: true,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
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

  Widget _buildPhotoUploadSection(BuildContext context, dynamic user) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _isUploadingPhoto ? null : _pickPhoto,
            child: Stack(
              children: [
                ClipOval(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: _selectedPhoto != null
                        ? Image.file(
                            _selectedPhoto!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _placeholderAvatar(context),
                          )
                        : (user.profilePhotoUrl != null && user.profilePhotoUrl!.isNotEmpty)
                            ? Image.network(
                                user.profilePhotoUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _placeholderAvatar(context),
                              )
                            : _placeholderAvatar(context),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.surface, width: 2),
                    ),
                    child: _isUploadingPhoto
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'profile_edit.upload_photo'.tr(),
            style: AppTypography.labelMedium.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _placeholderAvatar(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Icon(Icons.person, size: 50, color: Theme.of(context).colorScheme.outline),
    );
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );

    if (pickedFile != null && mounted) {
      setState(() => _isUploadingPhoto = true);

      try {
        await ref
            .read(profileProvider.notifier)
            .uploadPhoto(File(pickedFile.path));

        if (mounted) {
          setState(() {
            _selectedPhoto = File(pickedFile.path);
            _isUploadingPhoto = false;
          });
          showFloatingSnackBar(context, 'profile_edit.photo_uploaded'.tr());
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isUploadingPhoto = false);
          showFloatingSnackBar(
            context,
            'profile_edit.photo_upload_error'.tr(),
            backgroundColor: Theme.of(context).colorScheme.error,
          );
        }
      }
    }
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
            phoneCountryCode: _selectedCountryCode,
            phoneNumber: _phoneController.text.isEmpty
                ? null
                : _phoneController.text,
            birthDate: _selectedBirthDate,
            preferredLanguage: _selectedLanguage,
          );

      if (!mounted) {
        return;
      }

      showFloatingSnackBar(context, 'common.save'.tr());
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) {
        return;
      }

      showFloatingSnackBar(
        context,
        e.toString(),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }
}
