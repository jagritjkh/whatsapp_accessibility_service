import 'whatsapp_accessibility_service_platform_interface.dart';

///
class WhatsappAccessibilityService {
  Future<String?> getPlatformVersion() {
    return WhatsappAccessibilityServicePlatform.instance.getPlatformVersion();
  }

  /// request accessibility permission
  /// it will open the accessibility settings page and return `true` once the permission granted.
  static Future<bool> requestAccessibilityPermission() async {
    return WhatsappAccessibilityServicePlatform.instance
        .requestAccessibilityPermission();
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

  /// set custom suffix on which the service will work
  /// for eg. by default it is "          "
  static Future<String> setCustomSuffix(String suffix) async {
    return WhatsappAccessibilityServicePlatform.instance
        .setCustomSuffix(suffix);
  }

  /// set message to be send to whatsapp contact or group
  static Future<String> setMessage(String message) async {
    return WhatsappAccessibilityServicePlatform.instance
        .setMessage(message);
  }
}
