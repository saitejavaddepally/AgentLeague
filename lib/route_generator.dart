import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/Home/home.dart';
import 'package:agent_league/ui/Home/sell_screen.dart';
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
import 'package:agent_league/ui/property_info.dart';
import 'package:agent_league/ui/realtor_card.dart';
import 'package:agent_league/ui/sign_up.dart';
import 'package:agent_league/ui/signin_edit.dart';
import 'package:agent_league/ui/tour.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return PageTransition(
            child: const BottomBar(), type: PageTransitionType.leftToRight);
      case '/onboard':
        return PageTransition(
            child: const Onboarding(), type: PageTransitionType.leftToRight);
      case '/sign_in_edit':
        return PageTransition(
            child: const SignInEdit(), type: PageTransitionType.leftToRight);
      case '/sign_up':
        return PageTransition(
            child: const SignUpForm(), type: PageTransitionType.leftToRight);
      case '/help':
        return PageTransition(
            child: const Help(), type: PageTransitionType.leftToRight);
      case '/otp':
        {
          if (args is List) {
            return PageTransition(
                child: Otp(args: args), type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case '/leads_box':
        return PageTransition(
            child: const LeadBox(), type: PageTransitionType.leftToRight);
      case '/profile':
        return PageTransition(
            child: const Profile(), type: PageTransitionType.leftToRight);
      case '/explore':
        return PageTransition(
            child: const Explore(), type: PageTransitionType.leftToRight);
      case '/realtor_card':
        return PageTransition(
            child: const RealtorCard(), type: PageTransitionType.leftToRight);
      case '/home':
        return PageTransition(
            child: const Home(), type: PageTransitionType.leftToRight);
      case '/sell':
        return PageTransition(
            child: const SellScreen(), type: PageTransitionType.leftToRight);
      case '/amenties':
        return PageTransition(
            child: const Amenties(), type: PageTransitionType.leftToRight);
      case '/emi':
        return PageTransition(
            child: const EMI(), type: PageTransitionType.leftToRight);
      case '/documents':
        return PageTransition(
            child: const Documents(), type: PageTransitionType.leftToRight);
      case '/tour':
        return PageTransition(
            child: const Tour(), type: PageTransitionType.leftToRight);
      case '/post_page_one':
        return PageTransition(
            child: const PostYourPropertyPageOne(),
            type: PageTransitionType.leftToRight);
      case '/post_page_two':
        return PageTransition(
            child: const PostYourPropertyPageTwo(),
            type: PageTransitionType.leftToRight);
      case '/location':
        return PageTransition(
            child: const LocationScreen(),
            type: PageTransitionType.leftToRight);
      case '/gallery':
        return PageTransition(
            child: const GalleryScreen(), type: PageTransitionType.leftToRight);
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
