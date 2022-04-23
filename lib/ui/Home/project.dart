import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class Project extends StatefulWidget {
  const Project({Key? key}) : super(key: key);

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.keyboard_backspace_rounded)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteName.addProject);
              },
              child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: shadow1,
                      border: Border.all(color: HexColor('FD7E0E'))),
                  child: Row(children: const [
                    Icon(Icons.add),
                    Text(
                      " Add Your Project",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.4),
                    )
                  ])),
            )
          ]),
          const SizedBox(height: 25),
          TextField(
            cursorColor: Colors.white.withOpacity(0.1),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: "Search by company, project or location",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.3)),
              fillColor: Colors.white.withOpacity(0.1),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(text: 'Villa'),
              MoreButton(onTap: () {})
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: CustomImage(
                      onTap: () =>
                          Navigator.pushNamed(context, '/project_explorer'))),
              const SizedBox(width: 15),
              Expanded(
                  child: CustomImage(
                      onTap: () =>
                          Navigator.pushNamed(context, '/project_explorer')))
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(text: 'Hi - rise Flats'),
              MoreButton(onTap: () {})
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: CustomImage(
                      onTap: () =>
                          Navigator.pushNamed(context, '/project_explorer'))),
              const SizedBox(width: 15),
              Expanded(
                  child: CustomImage(
                      onTap: () =>
                          Navigator.pushNamed(context, '/project_explorer')))
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(text: 'HMDA'),
              MoreButton(onTap: () {})
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: CustomImage(
                      onTap: () =>
                          Navigator.pushNamed(context, '/project_explorer'))),
              const SizedBox(width: 15),
              Expanded(
                  child: CustomImage(
                      onTap: () =>
                          Navigator.pushNamed(context, '/project_explorer')))
            ],
          ),
        ]),
      )),
    ));
  }
}

class CustomImage extends StatelessWidget {
  final double height;
  final void Function() onTap;
  const CustomImage({required this.onTap, this.height = 100, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            boxShadow: shadow1, borderRadius: BorderRadius.circular(10)),
        child: Image.asset("assets/project.png", fit: BoxFit.fill),
      ),
    );
  }
}

class MoreButton extends StatelessWidget {
  final void Function() onTap;
  const MoreButton({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text('more',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.4,
              color: HexColor('FE7F0E'))),
    );
  }
}
