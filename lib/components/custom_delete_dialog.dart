import 'package:agent_league/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomDeleteDialog extends StatelessWidget {
  final void Function()? onCancel;
  final void Function()? onDelete;
  final String? content;
  const CustomDeleteDialog(
      {this.onCancel, this.onDelete, this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: CustomColors.dark,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
            child: Image.asset('assets/delete_dialog.png'),
          ),
          const SizedBox(height: 15),
          Text(
            'Delete $content?',
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: -0.15,
                color: Colors.black),
          ),
          const SizedBox(height: 10),
          Text(
            'Deleting this $content will place it in the trash',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.15,
                color: Colors.black),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: onCancel,
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    fixedSize: const Size(100, 41),
                    backgroundColor: HexColor('FACEA7')),
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14)),
              ),
              TextButton(
                onPressed: onDelete,
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    fixedSize: const Size(100, 41),
                    backgroundColor: HexColor('FD7E0E')),
                child: const Text('Delete',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
              )
            ],
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
