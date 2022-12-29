import 'package:agent_league/components/custom_container.dart';
import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/helper/string_manager.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
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
          Column(
            children: [
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
                  CustomTitle(text: 'hmda'.toUpperCase()),
                  MoreButton(onTap: () {})
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  initialData: const [],
                  future: FirestoreDataProvider.getAllHmdaProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return SizedBox(
                        height: 120,
                        child: Center(
                          child: CustomLabel(text: snapshot.error.toString()),
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return const SizedBox(
                        height: 120,
                        child: Center(
                          child: CustomLabel(text: "No projects Found"),
                        ),
                      );
                    }
                    return CustomGridView(projects: snapshot.data!);
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTitle(text: 'hiRise'.toUpperCase()),
                  MoreButton(onTap: () {})
                ],
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  initialData: const [],
                  future: FirestoreDataProvider.getAllHiRiseProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return SizedBox(
                        height: 120,
                        child: Center(
                          child: CustomLabel(text: snapshot.error.toString()),
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return const SizedBox(
                        height: 120,
                        child: Center(
                          child: CustomLabel(text: "No projects Found"),
                        ),
                      );
                    }
                    return CustomGridView(projects: snapshot.data!);
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTitle(text: 'Villas'.toUpperCase()),
                  MoreButton(onTap: () {})
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  initialData: const [],
                  future: FirestoreDataProvider.getAllVillasProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return SizedBox(
                        height: 120,
                        child: Center(
                          child: CustomLabel(text: snapshot.error.toString()),
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return const SizedBox(
                        height: 120,
                        child: Center(
                          child: CustomLabel(text: "No projects Found"),
                        ),
                      );
                    }
                    return CustomGridView(projects: snapshot.data!);
                  }),
            ],
          ),
        ]),
      )),
    ));
  }
}

class CustomImage extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final double height;

  const CustomImage(
      {required this.onTap, required this.image, this.height = 120, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        child: SizedBox(
          height: height,
          child: Image.network(image, fit: BoxFit.fill),
          width: MediaQuery.of(context).size.width,
        ),
        width: 100,
      ).use(),
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

class CustomGridView extends StatelessWidget {
  final List<Map<String, dynamic>> projects;

  const CustomGridView({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: (projects.length > 2) ? 2 : projects.length,
        primary: false,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10, crossAxisCount: 2),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CustomImage(
              onTap: () {
                Navigator.pushNamed(context, RouteName.projectExplorer,
                    arguments: projects[index]);
              },
              image: projects[index][StringManager.imagesKey][0]);
        });
  }
}
