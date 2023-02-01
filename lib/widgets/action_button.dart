import 'package:chatter/theme.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.color,
    required this.icon,
    this.size = 54,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
        BoxShadow(color: color.withOpacity(0.1), spreadRadius: 1, blurRadius: 24, offset: const Offset(-22, 0)),
        BoxShadow(color: color.withOpacity(0.1), spreadRadius: 1, blurRadius: 24, offset: const Offset(22, 0)),
        BoxShadow(color: color.withOpacity(0.1), spreadRadius: 8, blurRadius: 48, offset: const Offset(-22, 0)),
        BoxShadow(color: color.withOpacity(0.1), spreadRadius: 8, blurRadius: 48, offset: const Offset(22, 0)),
      ]),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: AppColors.cardLight,
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: size / 2,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
