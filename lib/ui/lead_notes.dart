import 'package:agent_league/components/custom_text_field.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../components/custom_button.dart';
import '../theme/colors.dart';
import 'package:flutter/services.dart';

class LeadNotes extends StatefulWidget {
  final String leadId;
  const LeadNotes({required this.leadId, Key? key}) : super(key: key);

  @override
  State<LeadNotes> createState() => _LeadNotesState();
}

class _LeadNotesState extends State<LeadNotes> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Flexible(
            child: CustomButton(
              text: 'Cancel',
              onClick: () {},
              color: HexColor('082640'),
              width: 89,
              height: 41,
            ).use(),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: CustomButton(
              text: 'Save',
              onClick: () async {
                await EasyLoading.show(status: 'Please wait...');
                await FirestoreDataProvider.updateLeadNotes(
                    widget.leadId, _textController.text);
                EasyLoading.showSuccess('Notes Updated',
                    duration: const Duration(seconds: 1));
              },
              color: HexColor('FD7E0E'),
              width: 85,
              height: 41,
            ).use(),
          ),
        ]),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                        text: "close_round",
                        onClick: () {
                          Navigator.pop(context);
                        },
                        isIcon: true,
                        height: 40,
                        width: 40,
                        color: HexColor('FD7E0E'),
                        rounded: true)
                    .use(),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Important points (if any):'),
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: FirestoreDataProvider.getLeadNotes(widget.leadId),
              initialData: '',
              builder: (context, snapshot) => CustomTextField(
                keyboardType: TextInputType.multiline,
                hint: "Click to type",
                controller: _textController..text = snapshot.data ?? '',
                maxLines: 17,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () async {
                  await Clipboard.setData(
                      ClipboardData(text: _textController.text));
                  await EasyLoading.showToast('Copied to Clipboard');
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(105, 42),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/copy.png'),
                    const SizedBox(width: 5),
                    const Text('Copy', style: TextStyle(color: Colors.black))
                  ],
                )),
          ]),
        ),
      )),
    );
  }
}
