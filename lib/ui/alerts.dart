import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/custom_title.dart';

class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  @override
  void initState() {
    FirestoreDataProvider()
        .readAll()
        .then((value) => {})
        .catchError((error) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.keyboard_backspace_rounded)),
                const SizedBox(width: 20),
                const Flexible(child: CustomTitle(text: 'Alerts'))
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<
                List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
              future: FirestoreDataProvider().getAllNotifications(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data?[index].data();

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        margin:
                            const EdgeInsets.only(top: 20, right: 20, left: 20),
                        decoration: BoxDecoration(
                            boxShadow: shadow1,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white.withOpacity(0.1)),
                        child: Column(children: [
                          Text(
                            data?['body'],
                            style: (TextStyle(
                                fontWeight: (data?['isRead'])
                                    ? FontWeight.normal
                                    : FontWeight.bold)),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(formatTimestamp(data?['timestamp'])),
                            ],
                          )
                        ]),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                      child: CustomTitle(text: 'Something Went Wrong'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  static String formatTimestamp(Timestamp timestamp) {
    // return DateFormat().add_yMd().add_jm().format(timestamp.toDate());
    var format = DateFormat('d-MM-y h:mm:a'); // <- use skeleton here
    return format.format(timestamp.toDate());
  }
}
