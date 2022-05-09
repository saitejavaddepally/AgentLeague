import 'package:bubble/bubble.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _messageController = TextEditingController();
  List<Map> messsages = [];

  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: 'assets/service/service.json').build();

    DialogFlow dialogFlow =
        DialogFlow(authGoogle: authGoogle, language: Language.english);

    AIResponse aiResponse = await dialogFlow.detectIntent(query);
    print(aiResponse.getListMessage()?[0]['text']['text'][0].toString());
    setState(() {
      messsages.insert(0, {
        'data': 0,
        'messages':
            aiResponse.getListMessage()?[0]['text']['text'][0].toString()
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Flexible(
            child: ListView.builder(
                reverse: true,
                itemCount: messsages.length,
                itemBuilder: (context, index) => chat(
                    messsages[index]["messages"].toString(),
                    messsages[index]["data"]))),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _messageController,
                cursorColor: Colors.white.withOpacity(0.1),
                onChanged: (value) {},
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "   Enter Message",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.3)),
                    fillColor: Colors.white.withOpacity(0.1),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(31)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(31))),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: GestureDetector(
                  onTap: () {
                    if (_messageController.text.isEmpty) {
                      print("empty message");
                    } else {
                      setState(() {
                        messsages.insert(0,
                            {"data": 1, "messages": _messageController.text});
                      });
                      response(_messageController.text);
                      _messageController.clear();
                    }
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: const Icon(Icons.send)),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10)
      ]),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/robot.png"),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Bubble(
                radius: const Radius.circular(15.0),
                color: data == 0
                    ? const Color.fromRGBO(23, 157, 139, 1)
                    : Colors.orangeAccent,
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/default.jpg"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
