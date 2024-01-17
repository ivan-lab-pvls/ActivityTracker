import 'package:activity_tracker/my_theme.dart';
import 'package:flutter/material.dart';

class MyFlatButton extends StatelessWidget {
  const MyFlatButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
  });
  final VoidCallback onTap;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).primaryColor,
        ),
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: MyTheme.whiteColor,
          ),
        ),
      ),
    );
  }
}
