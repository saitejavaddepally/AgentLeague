import 'package:agent_league/Services/payment_razorpay.dart';
import 'package:agent_league/ui/Home/Chat/chat_detail.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/project_screen/add_project.dart';
import 'package:agent_league/ui/alerts.dart';
import 'package:agent_league/ui/sell_screens/saved.dart';
import 'package:agent_league/ui/sell_screens/search_by.dart';
import 'package:agent_league/ui/sell_screens/amenties.dart';
import 'package:agent_league/ui/browcher.dart';
import 'package:agent_league/ui/coinsfly_wallet.dart';
import 'package:agent_league/ui/documents.dart';
import 'package:agent_league/ui/emi.dart';
import 'package:agent_league/ui/escrow.dart';
import 'package:agent_league/ui/explore.dart';
import 'package:agent_league/ui/gallery.dart';
import 'package:agent_league/ui/help.dart';
import 'package:agent_league/ui/layout.dart';
import 'package:agent_league/ui/leads_screens/lead_box.dart';
import 'package:agent_league/ui/leads_screens/lead_notes.dart';
import 'package:agent_league/ui/leads_screens/lead_status.dart';
import 'package:agent_league/ui/sell_screens/listing.dart';
import 'package:agent_league/ui/listing_property.dart';
import 'package:agent_league/ui/location.dart';
import 'package:agent_league/ui/auth_screens/login.dart';
import 'package:agent_league/ui/monthly_emi.dart';
import 'package:agent_league/ui/onboarding.dart';
import 'package:agent_league/ui/auth_screens/otp.dart';
import 'package:agent_league/ui/sell_screens/post_your_property_page_one.dart';
import 'package:agent_league/ui/profile/profile.dart';
import 'package:agent_league/ui/project_screen/project_explorer.dart';
import 'package:agent_league/ui/project_screen/property.dart';
import 'package:agent_league/ui/property_buying_score.dart';
import 'package:agent_league/ui/sell_screens/property_digitalization.dart';
import 'package:agent_league/ui/sell_screens/post_your_property_page_two.dart';
import 'package:agent_league/ui/property_loan.dart';
import 'package:agent_league/ui/property_range.dart';
import 'package:agent_league/ui/realtor_video.dart';
import 'package:agent_league/ui/sell_screens/realtor_card.dart';

import 'package:agent_league/ui/show_property_range.dart';
import 'package:agent_league/ui/auth_screens/sign_up.dart';

import 'package:agent_league/ui/tour.dart';
import 'package:agent_league/ui/project_screen/uploads_screen.dart';
import 'package:agent_league/ui/sell_screens/uploading_progress_page.dart';
import 'package:agent_league/ui/vasthu.dart';
import 'package:agent_league/ui/wallet_history.dart';
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
  static const String login = '/login';
  static const String listing = '/listing';
  static const String weHear = '/we_hear';
  static const String escrow = '/escrow';
  static const String monthlyEmi = '/monthly_emi';
  static const String propertyLoan = '/property_loan';
  static const String vasthu = '/vasthu';
  static const String listingPropertyBox = '/listing_property_box';
  static const String leadStatus = '/lead_status';
  static const String leadNotes = '/lead_notes';
  static const String walletHistory = '/wallet_history';
  static const String propertyRange = '/property_range';
  static const String showPropertyRange = '/show_property_range';
  static const String layout = '/layout';
  static const String realtorVideo = '/realtorVideo';
  static const String broucher = '/broucher';
  static const String uploadingProgress = '/upload_progress';
  static const String saveProperty = '/saved_property';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case RouteName.bottomBar:
        {
          if (args is int) {
            return PageTransition(
                child: BottomBar(index: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.weHear:
        return PageTransition(
            child: const WeHear(), type: PageTransitionType.leftToRight);
      case RouteName.monthlyEmi:
        return PageTransition(
            child: const MonthlyEmi(), type: PageTransitionType.leftToRight);
      case RouteName.escrow:
        return PageTransition(
            child: const Escrow(), type: PageTransitionType.leftToRight);
      case RouteName.onboard:
        return PageTransition(
            child: const Onboarding(), type: PageTransitionType.leftToRight);
      case RouteName.alerts:
        return PageTransition(
            child: const Alerts(), type: PageTransitionType.leftToRight);

      case RouteName.signUp:
        if (args is List) {
          return PageTransition(
              child: SignUpForm(countryCode: args[0], phoneNumber: args[1]),
              type: PageTransitionType.leftToRight);
        }
        return _errorRoute();
      case RouteName.help:
        return PageTransition(
            child: const Help(), type: PageTransitionType.leftToRight);
      case RouteName.otp:
        {
          if (args is List) {
            return PageTransition(
                child: Otp(
                    countryCode: args[0],
                    phoneNumber: args[1],
                    isUpdate: args[2]),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.leadsBox:
        {
          if (args is String?) {
            return PageTransition(
                child: LeadBox(docId: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.login:
        return PageTransition(
            child: const Login(), type: PageTransitionType.leftToRight);

      case RouteName.projectExplorer:
        {
          if (args is Map<String, dynamic>) {
            return PageTransition(
                child: ProjectExplorer(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.profile:
        return PageTransition(
            child: const Profile(), type: PageTransitionType.leftToRight);
      case RouteName.explore:
        return PageTransition(
            child: const Explore(), type: PageTransitionType.leftToRight);
      case RouteName.realtorCard:
        {
          if (args is Map<String, dynamic>) {
            return PageTransition(
                child: RealtorCard(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.emi:
        {
          if (args is int) {
            return PageTransition(
                child: EMI(price: args), type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.documents:
        {
          if (args is List) {
            return PageTransition(
                child: Documents(docs: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.tour:
        {
          if (args is List) {
            return PageTransition(
                child: Tour(videos: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.postYourPropertyPageOne:
        if (args is List) {
          return PageTransition(
              child: PostYourPropertyPageOne(
                  dataToEdit: args[0], isFreeListing: args[1]),
              type: PageTransitionType.leftToRight);
        }
        return _errorRoute();
      case RouteName.postYourPropertyPageTwo:
        {
          if (args is List) {
            return PageTransition(
                child: PostYourPropertyPageTwo(
                    previousPageData: args[0],
                    dataToEdit: args[1],
                    isFreeListing: args[2]),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.amenities:
        {
          if (args is List) {
            return PageTransition(
                child: Amenties(
                    previousPageData: args[0],
                    dataToEdit: args[1],
                    isFreeListing: args[2]),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.saveProperty:
        return PageTransition(
            child: const Saved(), type: PageTransitionType.leftToRight);

      case RouteName.searchBy:
        {
          if (args is List<Map<String, dynamic>>) {
            return PageTransition(
                child: SeachBy(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.location:
        {
          if (args is List) {
            return PageTransition(
                child: LocationScreen(latitude: args[0], longitude: args[1]),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.realtorVideo:
        {
          if (args is List) {
            return PageTransition(
                child: RealtorVideo(videos: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.broucher:
        {
          if (args is List) {
            return PageTransition(
                child: Broucher(docs: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.gallery:
        {
          if (args is List) {
            return PageTransition(
                child: GalleryScreen(images: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

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
      case RouteName.walletHistory:
        return PageTransition(
            child: const WalletHistory(), type: PageTransitionType.leftToRight);
      case RouteName.uploads:
        return PageTransition(
            child: const UploadsScreen(
              projectInfo: {},
            ),
            type: PageTransitionType.leftToRight);

      case RouteName.propertyBuyingScore:
        return PageTransition(
            child: const PropertyBuyingScore(),
            type: PageTransitionType.leftToRight);
      case RouteName.propertyDigitalization:
        if (args is Map<String, dynamic>) {
          return PageTransition(
              child: PropertyDigitalization(previousData: args),
              type: PageTransitionType.leftToRight);
        }
        return _errorRoute();

      case RouteName.paymentRazorpay:
        {
          if (args is Map) {
            return PageTransition(
                child: PaymentRazorpay(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.chatDetail:
        {
          if (args is List) {
            return PageTransition(
                child: ChatDetail(friendUid: args[0], friendName: args[1]),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
      case RouteName.listing:
        return PageTransition(
            child: const Listing(), type: PageTransitionType.leftToRight);

      case RouteName.propertyLoan:
        return PageTransition(
            child: const PropertyLoan(), type: PageTransitionType.leftToRight);

      case RouteName.vasthu:
        return PageTransition(
            child: const VasthuScreen(), type: PageTransitionType.leftToRight);

      case RouteName.propertyRange:
        {
          if (args is List<num>) {
            return PageTransition(
                child: PropertyRange(ranges: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.showPropertyRange:
        {
          if (args is List<num>) {
            return PageTransition(
                child: ShowPropertyRange(range: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.leadStatus:
        {
          if (args is List) {
            return PageTransition(
                child: LeadStatus(leadId: args[0], currentStatus: args[1]),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.uploadingProgress:
        {
          if (args is List) {
            return PageTransition(
                child: UploadingProgress(
                  previousData: args[0],
                  dataToEdit: args[1],
                  isFreeListing: args[2],
                  image: args[3],
                  docs: args[4],
                  videos: args[5],
                  imagesIndex: args[6],
                  docsIndex: args[7],
                  videosIndex: args[8],
                ),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.layout:
        {
          return PageTransition(
              child: const Layout(), type: PageTransitionType.leftToRight);
        }

      case RouteName.leadNotes:
        {
          if (args is String) {
            return PageTransition(
                child: LeadNotes(leadId: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.listingPropertyBox:
        {
          if (args is String) {
            return PageTransition(
                child: ListingPropertyBox(id: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }
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
