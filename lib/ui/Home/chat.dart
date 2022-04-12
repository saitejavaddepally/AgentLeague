import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Flexible(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container();
              }),
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
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
              child:
                  GestureDetector(onTap: () {}, child: const Icon(Icons.send)),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10)
      ]),
    );
  }
}
