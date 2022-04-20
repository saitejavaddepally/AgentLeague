import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/amenties.dart';
import 'package:agent_league/ui/documents.dart';
import 'package:agent_league/ui/emi.dart';
import 'package:agent_league/ui/explore.dart';
import 'package:agent_league/ui/gallery.dart';
import 'package:agent_league/ui/help.dart';
import 'package:agent_league/ui/lead_box.dart';
import 'package:agent_league/ui/location.dart';
import 'package:agent_league/ui/onboarding.dart';
import 'package:agent_league/ui/otp.dart';
import 'package:agent_league/ui/post_your_property.dart';
import 'package:agent_league/ui/profile.dart';
import 'package:agent_league/ui/project_explorer.dart';
import 'package:agent_league/ui/property_info.dart';
import 'package:agent_league/ui/realtor_card.dart';
import 'package:agent_league/ui/sign_up.dart';
import 'package:agent_league/ui/signin_edit.dart';
import 'package:agent_league/ui/tour.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteName {
  static const String bottomBar = '/bottomBar';
  static const String onboard = '/onboard';
  static const String signInEdit = '/sign_in_edit';
  static const String signUp = '/sign_up';
  static const String help = '/help';
  static const String otp = '/otp';
  static const String leadsBox = '/leads_box';
  static const String profile = '/profile';
  static const String explore = '/explore';
  static const String realtorCard = '/realtor_card';
  static const String amenities = '/amenties';
  static const String emi = '/emi';
  static const String documents = '/documents';
  static const String tour = '/tour';
  static const String postYourPropertyPageOne = '/post_page_one';
  static const String postYourPropertyPageTwo = '/post_page_two';
  static const String location = '/location';
  static const String gallery = '/gallery';
  static const String projectExplorer = '/project_explorer';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print("Route name : ${settings.name}");
    switch (settings.name) {
      case RouteName.bottomBar:
        return PageTransition(
            child: const BottomBar(), type: PageTransitionType.leftToRight);
      case RouteName.onboard:
        return PageTransition(
            child: const Onboarding(), type: PageTransitionType.leftToRight);
      case RouteName.signInEdit:
        return PageTransition(
            child: const SignInEdit(), type: PageTransitionType.leftToRight);
      case RouteName.signUp:
        return PageTransition(
            child: const SignUpForm(), type: PageTransitionType.leftToRight);
      case RouteName.help:
        return PageTransition(
            child: const Help(), type: PageTransitionType.leftToRight);
      case RouteName.otp:
        {
          if (args is String) {
            return PageTransition(
                child: Otp(args: args), type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.leadsBox:
        return PageTransition(
            child: const LeadBox(), type: PageTransitionType.leftToRight);
      case RouteName.profile:
        return PageTransition(
            child: const Profile(), type: PageTransitionType.leftToRight);
      case RouteName.explore:
        return PageTransition(
            child: const Explore(), type: PageTransitionType.leftToRight);
      case RouteName.realtorCard:
        return PageTransition(
            child: const RealtorCard(), type: PageTransitionType.leftToRight);
      case RouteName.amenities:
        return PageTransition(
            child: const Amenties(), type: PageTransitionType.leftToRight);
      case RouteName.emi:
        return PageTransition(
            child: const EMI(), type: PageTransitionType.leftToRight);
      case RouteName.documents:
        return PageTransition(
            child: const Documents(), type: PageTransitionType.leftToRight);
      case RouteName.tour:
        return PageTransition(
            child: const Tour(), type: PageTransitionType.leftToRight);
      case RouteName.postYourPropertyPageOne:
        return PageTransition(
            child: const PostYourPropertyPageOne(),
            type: PageTransitionType.leftToRight);
      case RouteName.postYourPropertyPageTwo:
        return PageTransition(
            child: const PostYourPropertyPageTwo(),
            type: PageTransitionType.leftToRight);
      case RouteName.location:
        return PageTransition(
            child: const LocationScreen(),
            type: PageTransitionType.leftToRight);
      case RouteName.gallery:
        return PageTransition(
            child: const GalleryScreen(), type: PageTransitionType.leftToRight);
      case RouteName.projectExplorer:
        return PageTransition(
            child: const ProjectExplorer(),
            type: PageTransitionType.leftToRight);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(child: Text('ERROR')),
      );
    });
  }
}