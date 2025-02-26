



import 'package:get/get.dart';
import 'package:mind_valley/Appointment/appointment_page.dart';
import 'package:mind_valley/Profile/profile_page.dart';
import 'package:mind_valley/configurations/app_routes.dart';
import 'package:mind_valley/home/home.dart';
import 'package:mind_valley/Therapist/therapist_page.dart';
import 'package:mind_valley/login%20sign%20up/login_page.dart';
import 'package:mind_valley/login%20sign%20up/sign_up_page.dart';
import 'package:mind_valley/mood/mood.dart';
import 'package:mind_valley/mood/moodLog_page.dart';
import 'package:mind_valley/ressources/ressource_page.dart';
import 'package:mind_valley/ressources/webview_page.dart';

class GenerateRoutes {
  static List<GetPage> getPages() {
    return [
      GetPage(name: AppRoutes.login_page, page:() =>  LoginPage()),
      GetPage(name: AppRoutes.sign_up_page, page:() =>  SignUpPage()),
      GetPage(name: AppRoutes.home, page:() =>  Home()),
      GetPage(name: AppRoutes.therapist_page, page:() => TherapistPage()),
      GetPage(name: AppRoutes.mood, page:() =>  MoodPage()),
      GetPage(name: AppRoutes.ressource_page, page: () =>  RessourcePage()),
      GetPage(name: AppRoutes.webview_page, page: () =>   WebViewPage()),
      GetPage(name: AppRoutes.profile_page, page: () =>  ProfilePage()),
      GetPage(name: AppRoutes.appointment_page, page: () =>  AppointmentPage()),
      GetPage(name: AppRoutes.moodLog_page, page: () =>  MoodLogPage()),
    ];
  }
}