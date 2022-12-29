import 'dart:developer';
import 'dart:io';

import 'package:agent_league/helper/string_manager.dart';
import 'package:agent_league/helper/utility_methods.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController refController = TextEditingController();
  TextEditingController agentExpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String imageUrl = '';
  String? countryCode;

  Future<void> getUserData() async {
    try {
      final userData = await FirestoreDataProvider.getUserInformation(
          FirebaseAuth.instance.currentUser!.uid);
      nameController.text = userData[StringManager.userNameKey];
      phoneNumberController.text = userData[StringManager.phoneNumberKey];
      locationController.text = userData[StringManager.locationKey];
      refController.text = userData[StringManager.referralCodeKey];
      agentExpController.text = userData[StringManager.agentExpKey];
      emailController.text = userData[StringManager.emailKey];
      imageUrl = userData[StringManager.profilePicKey];
      countryCode = userData[StringManager.countryCodeKey];
      return;
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> updateUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      Map<String, dynamic> data = {
        StringManager.userNameKey: nameController.text,
        StringManager.locationKey: locationController.text,
        StringManager.agentExpKey: agentExpController.text,
        StringManager.emailKey: emailController.text,
      };
      await FirestoreDataProvider.updateUserInfo(userId, data);
      await getUserData();
      notifyListeners();
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }

  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Location can't be empty";
    } else {
      return null;
    }
  }
}

class ProfilePicProvider extends ChangeNotifier {
  File? fileImage;
  Future<void> pickImage() async {
    try {
      final image = await Utils.pickImage();
      if (image == null) return;
      fileImage = image;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateImage() async {
    if (fileImage != null) {
      try {
        await FirestoreDataProvider.uploadProfilePicture(
            fileImage!, FirebaseAuth.instance.currentUser!.uid);
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
