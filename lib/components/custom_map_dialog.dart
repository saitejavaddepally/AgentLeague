import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomMapDialog extends StatelessWidget {
  const CustomMapDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.dark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ListTile(
                  title: const Text("Enter Current Location"),
                  onTap: () => Navigator.pop(context, 1)),
              ListTile(
                  title: const Text("Choose Current Location From Map"),
                  onTap: () => Navigator.pop(context, 2))
            ],
          ),
        ),
      ),
    );
  }
}