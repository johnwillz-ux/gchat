import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Widget child;
  final Color color;
  const ChatBubble({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}
