import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('vi'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In vi, this message translates to:
  /// **'Syna'**
  String get appName;

  /// No description provided for @welcomeBack.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng trở lại'**
  String get welcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Điều khiển ngôi nhà của bạn một cách dễ dàng'**
  String get loginSubtitle;

  /// No description provided for @email.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get signOut;

  /// No description provided for @createAccount.
  ///
  /// In vi, this message translates to:
  /// **'Tạo tài khoản'**
  String get createAccount;

  /// No description provided for @register.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get register;

  /// No description provided for @needAssistance.
  ///
  /// In vi, this message translates to:
  /// **'Cần hỗ trợ?'**
  String get needAssistance;

  /// No description provided for @home.
  ///
  /// In vi, this message translates to:
  /// **'Nhà'**
  String get home;

  /// No description provided for @rooms.
  ///
  /// In vi, this message translates to:
  /// **'Phòng'**
  String get rooms;

  /// No description provided for @automation.
  ///
  /// In vi, this message translates to:
  /// **'Tự động'**
  String get automation;

  /// No description provided for @assistant.
  ///
  /// In vi, this message translates to:
  /// **'Trợ lý'**
  String get assistant;

  /// No description provided for @energy.
  ///
  /// In vi, this message translates to:
  /// **'Điện năng'**
  String get energy;

  /// No description provided for @profile.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get notifications;

  /// No description provided for @goodMorning.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi sáng, {name}'**
  String goodMorning(String name);

  /// No description provided for @everythingSecure.
  ///
  /// In vi, this message translates to:
  /// **'Mọi thứ an toàn'**
  String get everythingSecure;

  /// No description provided for @activeDevices.
  ///
  /// In vi, this message translates to:
  /// **'{count} thiết bị đang hoạt động'**
  String activeDevices(int count);

  /// No description provided for @quickScenes.
  ///
  /// In vi, this message translates to:
  /// **'Ngữ cảnh nhanh'**
  String get quickScenes;

  /// No description provided for @favoriteDevices.
  ///
  /// In vi, this message translates to:
  /// **'Thiết bị yêu thích'**
  String get favoriteDevices;

  /// No description provided for @recentActivity.
  ///
  /// In vi, this message translates to:
  /// **'Hoạt động gần đây'**
  String get recentActivity;

  /// No description provided for @viewAll.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get viewAll;

  /// No description provided for @loading.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải'**
  String get loading;

  /// No description provided for @emptyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có dữ liệu'**
  String get emptyTitle;

  /// No description provided for @retry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get retry;

  /// No description provided for @offline.
  ///
  /// In vi, this message translates to:
  /// **'Đang ngoại tuyến, hiển thị dữ liệu cache'**
  String get offline;

  /// No description provided for @localMode.
  ///
  /// In vi, this message translates to:
  /// **'Kết nối Edge'**
  String get localMode;

  /// No description provided for @cloudMode.
  ///
  /// In vi, this message translates to:
  /// **'Kết nối Cloud'**
  String get cloudMode;

  /// No description provided for @deviceDetail.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết thiết bị'**
  String get deviceDetail;

  /// No description provided for @camera.
  ///
  /// In vi, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @deleteAccount.
  ///
  /// In vi, this message translates to:
  /// **'Xóa tài khoản'**
  String get deleteAccount;

  /// No description provided for @onboardingTitle.
  ///
  /// In vi, this message translates to:
  /// **'Syna kết nối ngôi nhà thông minh Edge-first'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Ưu tiên thiết bị nội bộ khi có Wi-Fi LAN và tự chuyển sang cloud khi cần.'**
  String get onboardingSubtitle;

  /// No description provided for @continueAction.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get continueAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
