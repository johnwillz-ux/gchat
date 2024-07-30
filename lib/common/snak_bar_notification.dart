import 'package:flutter/material.dart';

class ShowNotificationSnack {
  static void showError(BuildContext context, String title, String message) {
    _showSnackBar(context, title, message, Colors.red);
  }

  static void showSuccess(BuildContext context, String title, String message) {
    _showSnackBar(context, title, message, Colors.green);
  }

  static void _showSnackBar(
      BuildContext context, String title, String message, Color color) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Row(
        children: [
          Icon(
            color == Colors.red ? Icons.error : Icons.check,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
