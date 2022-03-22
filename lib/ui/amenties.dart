import 'package:agent_league/components/custom_title.dart';
import 'package:flutter/material.dart';

class Amenties extends StatefulWidget {
  const Amenties({Key? key}) : super(key: key);

  @override
  State<Amenties> createState() => _AmentiesState();
}

class _AmentiesState extends State<Amenties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_backspace_sharp)),
                const CustomTitle(text: 'Post Your Property')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
