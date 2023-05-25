import 'package:flutter/material.dart';

class IOSImmediateUpdateBottomSheet extends StatelessWidget {
  final String updateVersion;
  final String currentVersion;
  final void Function() onPressed;
  final void Function() closeBtnPressed;

  const IOSImmediateUpdateBottomSheet({
    super.key,
    required this.currentVersion,
    required this.updateVersion,
    required this.onPressed,
    required this.closeBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Align(
          alignment: Alignment.centerRight,
          child: CloseButton(onPressed: closeBtnPressed),
        ),
        const SizedBox(height: 80),
        Center(
          child: Text(
            "Update available for $updateVersion, app is currently running on $currentVersion",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Center(
          child: MaterialButton(
            onPressed: onPressed,
            child: const Text("Update app"),
          ),
        )
      ],
    );
  }
}
