import 'package:flutter/material.dart';

void showSnackbarWithColor(
    BuildContext context, String message, Color bgColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: bgColor,
      duration: const Duration(seconds: 2),
    ),
  );
}

String extractRequestId(String input) {
  final regex = RegExp(r'Request served by (\w+)$');
  final match = regex.firstMatch(input);
  if (match != null && match.groupCount > 0) {
    return match.group(1)!;
  }
  return '';
}
