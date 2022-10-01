import 'package:agent_league/provider/lead_screen_methods.dart';
import 'package:agent_league/provider/lead_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../theme/colors.dart';

class LeadStatus extends StatefulWidget {
  final String leadId;
  final String currentStatus;
  const LeadStatus(
      {required this.leadId, required this.currentStatus, Key? key})
      : super(key: key);

  @override
  State<LeadStatus> createState() => _LeadStatusState();
}

class _LeadStatusState extends State<LeadStatus> {
  late String status;
  bool isNewCustomer = false;

  @override
  void initState() {
    status = widget.currentStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LeadStatusProvider(status),
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomButton(
                text: 'Change Status',
                onClick: () async {
                  await EasyLoading.show(status: 'Please Wait...');
                  await LeadScreenMethods.changeLeadStatus(
                      widget.leadId, status);
                  EasyLoading.showSuccess('Status Change',
                      duration: const Duration(seconds: 1));
                },
                color: HexColor('FD7E0E'),
                width: 160,
                height: 40,
              ).use(),
            ]),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(children: [
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Consumer<LeadStatusProvider>(
                      builder: (context, value, child) => Column(children: [
                        ChangeLeadStatus(
                          text: 'New customer',
                          onTap: () {
                            status = 'new customer';
                            value.onPressButton(0);
                          },
                          buttonColor:
                              value.isChecked[0] ? Colors.yellow : Colors.white,
                          iconColor:
                              value.isChecked[0] ? Colors.white : Colors.yellow,
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 10),
                        ChangeLeadStatus(
                          text: 'Deal in progress',
                          onTap: () {
                            status = 'deal in progress';
                            value.onPressButton(1);
                          },
                          icon: Icons.access_time_filled,
                          buttonColor:
                              value.isChecked[1] ? Colors.orange : Colors.white,
                          iconColor:
                              value.isChecked[1] ? Colors.white : Colors.orange,
                        ),
                        const SizedBox(height: 10),
                        ChangeLeadStatus(
                          text: 'Deal successful',
                          onTap: () {
                            status = 'deal successful';
                            value.onPressButton(2);
                          },
                          buttonColor:
                              value.isChecked[2] ? Colors.green : Colors.white,
                          iconColor:
                              value.isChecked[2] ? Colors.white : Colors.green,
                          icon: Icons.check_circle,
                        ),
                        const SizedBox(height: 10),
                        ChangeLeadStatus(
                          text: 'Not interested',
                          onTap: () {
                            status = 'not interested';
                            value.onPressButton(3);
                          },
                          buttonColor:
                              value.isChecked[3] ? Colors.red : Colors.white,
                          iconColor:
                              value.isChecked[3] ? Colors.white : Colors.red,
                          icon: Icons.cancel,
                        ),
                      ]),
                    ),
                  ),
                ])),
          ))),
    );
  }
}

class ChangeLeadStatus extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final IconData icon;
  final Color iconColor;
  final Color buttonColor;

  const ChangeLeadStatus(
      {required this.text,
      required this.buttonColor,
      required this.iconColor,
      required this.icon,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        primary: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.only(left: 10),
        fixedSize: const Size(double.maxFinite, 48),
      ),
      onPressed: onTap,
      child: Row(children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 10),
        Text(text,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
      ]),
    );
  }
}
