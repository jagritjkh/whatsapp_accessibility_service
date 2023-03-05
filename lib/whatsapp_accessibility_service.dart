import 'package:whatsapp_accessibility_service/constants/constants.dart';

import 'whatsapp_accessibility_service_platform_interface.dart';

///
class WhatsappAccessibilityService {

  Future<String?> getPlatformVersion() {
    return WhatsappAccessibilityServicePlatform.instance.getPlatformVersion();
  }

  /// request accessibility permission
  /// it will open the accessibility settings page and return `true` once the permission granted.
  static Future<bool> requestAccessibilityPermission([String? suffix]) async {
    suffix ??= Constants.kSuffix;
    return WhatsappAccessibilityServicePlatform.instance
        .requestAccessibilityPermission(suffix);
  }

  /// check if accessibility permission is enabled
  static Future<bool> isAccessibilityPermissionEnabled() async {
    return WhatsappAccessibilityServicePlatform.instance
        .isAccessibilityPermissionEnabled();
  }

  /// set service enabled/disabled
  static Future<bool> setServiceEnabled(bool enable) async {
    return WhatsappAccessibilityServicePlatform.instance
        .setServiceEnabled(enable);
  }

  /// get suffix on which the service will work
  /// for eg. by default it is "          "
  static Future<String> getSuffix() async {
    return WhatsappAccessibilityServicePlatform.instance.getSuffix();
  }
}
