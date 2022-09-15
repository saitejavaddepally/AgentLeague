import 'dart:io';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:agent_league/Services/upload_properties_to_firestore.dart';
import 'package:agent_league/route_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:agent_league/location_service.dart';
import '../../components/custom_button.dart';
import '../../components/custom_label.dart';
import '../../components/custom_line_under_text.dart';
import '../../components/custom_map_dialog.dart';
import '../../components/custom_selector.dart';
import '../../components/custom_text_field.dart';
import '../../helper/constants.dart';
import '../../provider/post_your_property_provider_one.dart';
import '../../theme/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController refController = TextEditingController();
  TextEditingController agentExpController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String phoneNumber = '';
  bool isLoading = false;
  File? selectedImage;
  String? _chosenValue;
  String? _imageName;

  late double _latitude;
  late double _longitude;

  @override
  void initState() {
    grabUserDetails();
    super.initState();
  }

  Future<File?> pickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return null;
    List splitPath = image.path.split('/');
    _imageName = splitPath[splitPath.length - 1];

    final name = (_imageName.toString().length > 6)
        ? _imageName.toString().substring(0, 10) + "..."
        : _imageName.toString();

    print(_imageName);

    setState(() {
      _imageName = name;
    });
    final imageTemporary = File(image.path);
    // await UploadPropertiesToFirestore().uploadProfilePicture(imageTemporary);
    return imageTemporary;
  }

  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Location can't be empty";
    } else {
      return null;
    }
  }

  Future grabUserDetails() async {
    EasyLoading.show(status: 'Please wait..');
    await getDetails().catchError((error) {
      EasyLoading.dismiss();
    });
    EasyLoading.dismiss();
  }

  Future getDetails() async {
    await UploadPropertiesToFirestore().getProfileInformation().then((value) {
      print(value);
      setState(() {
        phoneNumber =
            phoneNumberController.text = value['phone'].toString().substring(3);
        nameController.text = value['name'];
        locationController.text = value['location'];
        emailController.text = value['email'];
        refController.text = value['ref_code'];
        agentExpController.text = value['agent_exp'];
        _imageName = value['profilePicture'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: CustomColors.dark,
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Column(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        boxShadow: shadow1,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.orange, width: 1.5)),
                                    child: (selectedImage != null ||
                                            _imageName != null)
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: (selectedImage != null)
                                                ? Image.file(
                                                    selectedImage!,
                                                    height: 40.0,
                                                    width: 40.0,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    _imageName!,
                                                    height: 40.0,
                                                    width: 40.0,
                                                    fit: BoxFit.fill,
                                                  ),
                                          )
                                        : Image.asset("assets/profile.png",
                                            fit: BoxFit.fill),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                        child: CustomLabel(text: 'Name :')),
                                    Flexible(
                                        child: CustomTextField(
                                      controller: nameController,
                                      onChanged: (value) {},
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
                                          child: CustomLabel(text: 'Mobile :')),
                                      Flexible(
                                        flex: 1,
                                        child: SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: phoneNumberController,
                                            // maxLength: 10,
                                            keyboardType: TextInputType.number,
                                            onChanged: (number) {
                                              phoneNumber = number;
                                            },

                                            validator: (number) {
                                              if (number == null ||
                                                  number.isEmpty ||
                                                  number.length != 10) {
                                                return "Enter Correct Mobile Number";
                                              }
                                              return null;
                                            },
                                            cursorColor:
                                                Colors.white.withOpacity(0.1),
                                            decoration: InputDecoration(
                                                prefixIcon: const Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text('+91 ')),
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                hintText:
                                                    "    Your number here",
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Colors.white
                                                        .withOpacity(0.3)),
                                                fillColor: Colors.white
                                                    .withOpacity(0.1),
                                                filled: true,
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: Colors.red,
                                                        width: 0.5),
                                                    borderRadius: BorderRadius.circular(
                                                        10)),
                                                focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: Colors.red,
                                                        width: 0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10))),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: CustomLabel(text: '')),
                                        Flexible(
                                          child: Center(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: CustomButton(
                                                    color: Colors.orange,
                                                    radius: 10,
                                                    height: 40,
                                                    text: "Authorize",
                                                    onClick: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName.otp,
                                                          arguments: [
                                                            "+91$phoneNumber",
                                                            "true"
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
                                        child: CustomLabel(text: 'Location :')),
                                    Expanded(
                                      child: CustomTextField(
                                        isDense: true,
                                        controller: locationController,
                                        readOnly: true,
                                        borderRadius: 10,
                                        validator: validateLocation,
                                        onTap: () async {
                                          final result = await showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) =>
                                                  const CustomMapDialog());

                                          if (result == 1) {
                                            setState(() => isLoading = true);
                                            final res = await GetUserLocation
                                                .getCurrentLocation();
                                            setState(() => isLoading = false);
                                            if (res != null && res.isNotEmpty) {
                                              locationController.text = res[0];
                                            }
                                          }
                                          if (result == 2) {
                                            final res = await GetUserLocation
                                                .getMapLocation(context);
                                            if (res.isNotEmpty) {
                                              locationController.text = res[0];
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
                                        child: CustomLabel(text: 'Ref. Code: '),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: CustomTextField(
                                                controller: refController,
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
                                        child: CustomLabel(text: 'Email ID')),
                                    Expanded(
                                        child: CustomTextField(
                                      controller: emailController,
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Expanded(
                                        child:
                                            CustomLabel(text: 'Exp (yrs) : ')),
                                    Expanded(
                                      child: CustomTextField(
                                        controller: agentExpController,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Expanded(
                                        child:
                                            CustomLabel(text: 'Profile pic :')),
                                    Flexible(
                                      flex: 1,
                                      child: SizedBox(
                                          height: 40,
                                          child: CustomButton(
                                                  radius: 10,
                                                  isNeu: false,
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  onClick: () async {
                                                    selectedImage =
                                                        await pickImage();
                                                    setState(() {
                                                      selectedImage;
                                                    });
                                                  },
                                                  text: '...')
                                              .use()),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // Row(
                                //   children: [
                                //     const Expanded(
                                //         child: CustomLabel(text: 'Agent Type :')),
                                //     Flexible(
                                //         child:  SizedBox(
                                //           height: 40,
                                //           child: CustomSelector(
                                //             dropDownItems: [
                                //               '',
                                //               'FreeLancer',
                                //               'Corporate',
                                //             ],
                                //             borderRadius: 10,
                                //             onChanged: (value) {
                                //               setState(() {
                                //                 _chosenValue = value;
                                //               });
                                //             },
                                //             chosenValue: _chosenValue,
                                //
                                //           ).use(),
                                //         ),
                                //     ),
                                //   ],
                                // ),
                              ]),
                          const SizedBox(height: 25),
                          const SizedBox(
                            height: 100,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 100),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: CustomButton(
                                                text: 'Cancel',
                                                color: CustomColors.dark,
                                                onClick: () {})
                                            .use())),
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: CustomButton(
                                            text: 'Submit',
                                            color: HexColor('FD7E0E'),
                                            onClick: () async {
                                              await EasyLoading.show(
                                                  status: 'Updating..');
                                              try {
                                                final userId = FirebaseAuth
                                                    .instance.currentUser?.uid;
                                                await UploadPropertiesToFirestore()
                                                    .uploadProfilePicture(
                                                        selectedImage);
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(userId)
                                                    .update(
                                                  {
                                                    'name': nameController.text,
                                                    'phone':
                                                        phoneNumberController
                                                            .text,
                                                    'location':
                                                        locationController.text,
                                                    'ref_code':
                                                        refController.text,
                                                    'email':
                                                        emailController.text,
                                                    'agent_exp':
                                                        agentExpController.text,
                                                    'profile_pic':
                                                        _imageName.toString(),
                                                  },
                                                );
                                              } on Exception catch (e) {
                                                print(e);
                                              }

                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        BottomBar(index: 0)),
                                                (r) => false,
                                              );
                                              await EasyLoading.showSuccess(
                                                  "Done..");
                                            }).use())),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
