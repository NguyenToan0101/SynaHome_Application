// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Syna';

  @override
  String get welcomeBack => 'Chào mừng trở lại';

  @override
  String get loginSubtitle => 'Điều khiển ngôi nhà của bạn một cách dễ dàng';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get signOut => 'Đăng xuất';

  @override
  String get createAccount => 'Tạo tài khoản';

  @override
  String get register => 'Đăng ký';

  @override
  String get needAssistance => 'Cần hỗ trợ?';

  @override
  String get home => 'Nhà';

  @override
  String get rooms => 'Phòng';

  @override
  String get automation => 'Tự động';

  @override
  String get assistant => 'Trợ lý';

  @override
  String get energy => 'Điện năng';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get settings => 'Cài đặt';

  @override
  String get notifications => 'Thông báo';

  @override
  String goodMorning(String name) {
    return 'Chào buổi sáng, $name';
  }

  @override
  String get everythingSecure => 'Mọi thứ an toàn';

  @override
  String activeDevices(int count) {
    return '$count thiết bị đang hoạt động';
  }

  @override
  String get quickScenes => 'Ngữ cảnh nhanh';

  @override
  String get favoriteDevices => 'Thiết bị yêu thích';

  @override
  String get recentActivity => 'Hoạt động gần đây';

  @override
  String get viewAll => 'Xem tất cả';

  @override
  String get loading => 'Đang tải';

  @override
  String get emptyTitle => 'Chưa có dữ liệu';

  @override
  String get retry => 'Thử lại';

  @override
  String get offline => 'Đang ngoại tuyến, hiển thị dữ liệu cache';

  @override
  String get localMode => 'Kết nối Edge';

  @override
  String get cloudMode => 'Kết nối Cloud';

  @override
  String get deviceDetail => 'Chi tiết thiết bị';

  @override
  String get camera => 'Camera';

  @override
  String get deleteAccount => 'Xóa tài khoản';

  @override
  String get onboardingTitle => 'Syna kết nối ngôi nhà thông minh Edge-first';

  @override
  String get onboardingSubtitle =>
      'Ưu tiên thiết bị nội bộ khi có Wi-Fi LAN và tự chuyển sang cloud khi cần.';

  @override
  String get continueAction => 'Tiếp tục';
}
