import 'package:flutter/material.dart';

void showFloatingSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 3),
  Color? backgroundColor,
  VoidCallback? onAction,
  String? actionLabel,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      duration: duration,
      backgroundColor: backgroundColor,
      action: onAction != null && actionLabel != null
          ? SnackBarAction(label: actionLabel, onPressed: onAction)
          : null,
    ),
  );
}
