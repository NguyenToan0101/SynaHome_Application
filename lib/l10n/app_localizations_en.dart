// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Syna';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle => 'Control your environment with ease';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get createAccount => 'Create an account';

  @override
  String get register => 'Register';

  @override
  String get needAssistance => 'Need assistance?';

  @override
  String get home => 'Home';

  @override
  String get rooms => 'Rooms';

  @override
  String get automation => 'Automation';

  @override
  String get assistant => 'Assistant';

  @override
  String get energy => 'Energy';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String goodMorning(String name) {
    return 'Good Morning, $name';
  }

  @override
  String get everythingSecure => 'Everything is secure';

  @override
  String activeDevices(int count) {
    return '$count devices active';
  }

  @override
  String get quickScenes => 'Quick scenes';

  @override
  String get favoriteDevices => 'Favorite devices';

  @override
  String get recentActivity => 'Recent activity';

  @override
  String get viewAll => 'View all';

  @override
  String get loading => 'Loading';

  @override
  String get emptyTitle => 'No data yet';

  @override
  String get retry => 'Retry';

  @override
  String get offline => 'Offline, showing cached data';

  @override
  String get localMode => 'Edge connected';

  @override
  String get cloudMode => 'Cloud connected';

  @override
  String get deviceDetail => 'Device detail';

  @override
  String get camera => 'Camera';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get onboardingTitle => 'Syna connects your edge-first smart home';

  @override
  String get onboardingSubtitle =>
      'Prefer the local LAN edge backend and fall back to cloud when needed.';

  @override
  String get continueAction => 'Continue';
}
