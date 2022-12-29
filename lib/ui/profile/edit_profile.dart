import 'package:agent_league/provider/edit_profile_provider.dart';
import 'package:agent_league/route_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../Services/location_service.dart';
import '../../components/custom_button.dart';
import '../../components/custom_label.dart';
import '../../components/custom_map_dialog.dart';
import '../../components/custom_text_field.dart';
import '../../helper/constants.dart';
import '../../theme/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EditProfileProvider()),
        ChangeNotifierProvider(create: (context) => ProfilePicProvider()),
      ],
      builder: (context, child) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Edit Profile Page",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: CustomColors.dark,
              leading: IconButton(
                padding: const EdgeInsets.only(left: 16),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Builder(builder: (context) {
                    final profileProvider =
                        Provider.of<ProfilePicProvider>(context, listen: false);
                    return FutureBuilder(
                        future: Provider.of<EditProfileProvider>(context,
                                listen: false)
                            .getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: CustomLabel(
                                    text: snapshot.error.toString()));
                          }
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: Consumer<EditProfileProvider>(
                                  builder: (context, value, child) => Column(
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Consumer<ProfilePicProvider>(
                                              builder:
                                                  (context, value1, child) =>
                                                      Center(
                                                child: Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        boxShadow: shadow1,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.orange,
                                                            width: 1.5)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      child: (value.imageUrl
                                                                  .isNotEmpty &&
                                                              value1.fileImage ==
                                                                  null)
                                                          ? CachedNetworkImage(
                                                              imageUrl: value
                                                                  .imageUrl,
                                                              height: 40.0,
                                                              width: 40.0,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : (value1.fileImage !=
                                                                  null)
                                                              ? Image.file(
                                                                  value1
                                                                      .fileImage!,
                                                                  fit: BoxFit
                                                                      .fill)
                                                              : Image.asset(
                                                                  "assets/profile.png",
                                                                  fit: BoxFit
                                                                      .fill),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomLabel(
                                                        text: 'Name :')),
                                                Flexible(
                                                    child: CustomTextField(
                                                  controller:
                                                      value.nameController,
                                                )),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(children: [
                                                  const Expanded(
                                                      child: CustomLabel(
                                                          text: 'Mobile :')),
                                                  Flexible(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      height: 40,
                                                      child: CustomTextField(
                                                        controller: value
                                                            .phoneNumberController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        validator: (number) {
                                                          if (number == null ||
                                                              number.isEmpty ||
                                                              number.length !=
                                                                  10) {
                                                            return "Enter Correct Mobile Number";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                        child: CustomLabel(
                                                            text: '')),
                                                    Flexible(
                                                      child: Center(
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: CustomButton(
                                                                color: Colors
                                                                    .orange,
                                                                radius: 10,
                                                                height: 40,
                                                                text:
                                                                    "Authorize",
                                                                onClick: () {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      RouteName
                                                                          .otp,
                                                                      arguments: [
                                                                        value
                                                                            .countryCode,
                                                                        value
                                                                            .phoneNumberController
                                                                            .text,
                                                                        true
                                                                      ]);
                                                                }).use()),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomLabel(
                                                        text: 'Location :')),
                                                Expanded(
                                                  child: CustomTextField(
                                                    isDense: true,
                                                    controller: value
                                                        .locationController,
                                                    readOnly: true,
                                                    borderRadius: 10,
                                                    validator:
                                                        value.validateLocation,
                                                    onTap: () async {
                                                      final result = await showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (context) =>
                                                              const CustomMapDialog());

                                                      if (result == 1) {
                                                        setState(() =>
                                                            isLoading = true);
                                                        final res =
                                                            await GetUserLocation
                                                                .getCurrentLocation();
                                                        setState(() =>
                                                            isLoading = false);
                                                        if (res != null &&
                                                            res.isNotEmpty) {
                                                          value
                                                              .locationController
                                                              .text = res[0];
                                                        }
                                                      }
                                                      if (result == 2) {
                                                        final res =
                                                            await GetUserLocation
                                                                .getMapLocation(
                                                                    context);
                                                        if (res != null &&
                                                            res.isNotEmpty) {
                                                          value
                                                              .locationController
                                                              .text = res[0];
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: true,
                                              child: Column(children: [
                                                const SizedBox(height: 10),
                                                Row(children: [
                                                  const Expanded(
                                                    child: CustomLabel(
                                                        text: 'Ref. Code: '),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child:
                                                              CustomTextField(
                                                            controller: value
                                                                .refController,
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                              ]),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomLabel(
                                                        text: 'Email ID')),
                                                Expanded(
                                                    child: CustomTextField(
                                                  controller:
                                                      value.emailController,
                                                )),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomLabel(
                                                        text: 'Exp (yrs) : ')),
                                                Expanded(
                                                  child: CustomTextField(
                                                    controller: value
                                                        .agentExpController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomLabel(
                                                        text: 'Profile pic :')),
                                                Flexible(
                                                  flex: 1,
                                                  child: SizedBox(
                                                      height: 40,
                                                      child: CustomButton(
                                                              radius: 10,
                                                              isNeu: false,
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.1),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              onClick:
                                                                  () async {
                                                                await profileProvider
                                                                    .pickImage();
                                                              },
                                                              text: '...')
                                                          .use()),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                          ]),
                                      const SizedBox(height: 25),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 100),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(9),
                                                    child: CustomButton(
                                                        text: 'Cancel',
                                                        color:
                                                            CustomColors.dark,
                                                        onClick: () {
                                                          Navigator.pop(
                                                              context);
                                                        }).use())),
                                            Expanded(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(9),
                                                    child: CustomButton(
                                                        text: 'Submit',
                                                        color:
                                                            HexColor('FD7E0E'),
                                                        onClick: () async {
                                                          await EasyLoading.show(
                                                              status:
                                                                  'Updating..');
                                                          await profileProvider
                                                              .updateImage();
                                                          await value
                                                              .updateUserData();
                                                          EasyLoading.showSuccess(
                                                              'Done',
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2));
                                                        }).use())),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  }),
                ),
              ),
            )),
      ),
    );
  }
}
