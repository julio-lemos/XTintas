import 'package:flutter/material.dart';

class XButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const XButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
              child: child,
            ),
          ),
        )
      ],
    );
  }
}
