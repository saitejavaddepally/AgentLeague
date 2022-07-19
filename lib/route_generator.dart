import 'package:agent_league/Services/payment_razorpay.dart';
import 'package:agent_league/ui/Home/Chat/chat_detail.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/add_project.dart';
import 'package:agent_league/ui/alerts.dart';
import 'package:agent_league/ui/amenties.dart';
import 'package:agent_league/ui/coinsfly_wallet.dart';
import 'package:agent_league/ui/documents.dart';
import 'package:agent_league/ui/emi.dart';
import 'package:agent_league/ui/escrow.dart';
import 'package:agent_league/ui/explore.dart';
import 'package:agent_league/ui/gallery.dart';
import 'package:agent_league/ui/help.dart';
import 'package:agent_league/ui/lead_box.dart';
import 'package:agent_league/ui/listing.dart';
import 'package:agent_league/ui/location.dart';
import 'package:agent_league/ui/onboarding.dart';
import 'package:agent_league/ui/otp.dart';
import 'package:agent_league/ui/post_your_property.dart';
import 'package:agent_league/ui/profile.dart';
import 'package:agent_league/ui/project_explorer.dart';
import 'package:agent_league/ui/property.dart';
import 'package:agent_league/ui/property_buying_score.dart';
import 'package:agent_league/ui/property_digitalization.dart';
import 'package:agent_league/ui/property_info.dart';
import 'package:agent_league/ui/realtor_card.dart';
import 'package:agent_league/ui/register.dart';
import 'package:agent_league/ui/search_by.dart';
import 'package:agent_league/ui/sign_up.dart';
import 'package:agent_league/ui/signin_edit.dart';
import 'package:agent_league/ui/success.dart';
import 'package:agent_league/ui/tour.dart';
import 'package:agent_league/ui/uploads_screen.dart';
import 'package:agent_league/ui/we_hear.dart';
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
  static const String addProject = '/add_project';
  static const String property = '/property';
  static const String wallet = '/wallet';
  static const String uploads = '/uploads';
  static const String chatDetail = '/chat_detail';
  static const String propertyBuyingScore = '/property_buying_score';
  static const String propertyDigitalization = '/property_digitalization';
  static const String searchBy = '/search_by';
  static const String success = '/success';
  static const String paymentRazorpay = '/r';
  static const String register = '/register';
  static const String alerts = '/alerts';
  static const String listing = '/listing';
  static const String weHear = '/we_hear';
  static const String escrow = '/escrow';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case RouteName.bottomBar:
        return PageTransition(
            child: BottomBar(
              isIndexGiven: false,
              index: 0,
            ),
            type: PageTransitionType.leftToRight);
      case RouteName.weHear:
        return PageTransition(
            child: const WeHear(), type: PageTransitionType.leftToRight);
      case RouteName.escrow:
        return PageTransition(
            child: const Escrow(), type: PageTransitionType.leftToRight);
      case RouteName.onboard:
        return PageTransition(
            child: const Onboarding(), type: PageTransitionType.leftToRight);
      case RouteName.alerts:
        return PageTransition(
            child: const Alerts(), type: PageTransitionType.leftToRight);
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
          if (args is List) {
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
      // case RouteName.realtorCard:
      //   return PageTransition(
      //       child: const RealtorCard(), type: PageTransitionType.leftToRight);
      case RouteName.amenities:
        {
          if (args is List) {
            return PageTransition(
                child: Amenties(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.emi:
        return PageTransition(
            child: const EMI(
              price: [],
            ),
            type: PageTransitionType.leftToRight);
      case RouteName.documents:
        return PageTransition(
            child: const Documents(
              documents: [],
            ),
            type: PageTransitionType.leftToRight);
      case RouteName.tour:
        return PageTransition(
            child: const Tour(
              videos: [],
            ),
            type: PageTransitionType.leftToRight);
      case RouteName.postYourPropertyPageOne:
        return PageTransition(
            child: PostYourPropertyPageOne(
                dataToEdit: args as Map<String, dynamic>?),
            type: PageTransitionType.leftToRight);
      case RouteName.postYourPropertyPageTwo:
        {
          if (args is List) {
            return PageTransition(
                child: PostYourPropertyPageTwo(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.location:
        return PageTransition(
            child: const LocationScreen(),
            type: PageTransitionType.leftToRight);
      case RouteName.gallery:
        return PageTransition(
            child: const GalleryScreen(images: []),
            type: PageTransitionType.leftToRight);
      case RouteName.projectExplorer:
        return PageTransition(
            child: const ProjectExplorer(),
            type: PageTransitionType.leftToRight);
      case RouteName.addProject:
        return PageTransition(
            child: const AddProject(), type: PageTransitionType.leftToRight);
      case RouteName.property:
        return PageTransition(
            child: const Property(), type: PageTransitionType.leftToRight);
      case RouteName.wallet:
        return PageTransition(
            child: const CoinsflyWallet(),
            type: PageTransitionType.leftToRight);
      case RouteName.uploads:
        return PageTransition(
            child: const UploadsScreen(), type: PageTransitionType.leftToRight);
      case RouteName.register:
        return PageTransition(
            child: const Register(), type: PageTransitionType.leftToRight);
      case RouteName.propertyBuyingScore:
        return PageTransition(
            child: const PropertyBuyingScore(),
            type: PageTransitionType.leftToRight);
      case RouteName.propertyDigitalization:
        if (args is Map<String, dynamic>) {
          return PageTransition(
              child: PropertyDigitalization(formData: args),
              type: PageTransitionType.leftToRight);
        }
        return _errorRoute();

      // case RouteName.success:
      //   {
      //     if (args is Map) {
      //       return PageTransition(
      //           child: const Success(data: {}),
      //           type: PageTransitionType.leftToRight);
      //     }
      //     return _errorRoute();
      //   }

      case RouteName.paymentRazorpay:
        {
          if (args is Map) {
            return PageTransition(
                child: PaymentRazorpay(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      // case RouteName.searchBy:
      //   return PageTransition(
      //       child: const SeachBy(), type: PageTransitionType.leftToRight);
      case RouteName.chatDetail:
        {
          if (args is List) {
            return PageTransition(
                child: ChatDetail(friendName: args[0], friendUid: args[1]),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.listing:
        return PageTransition(
            child: const Listing(), type: PageTransitionType.leftToRight);
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
