import 'whatsapp_accessibility_service_platform_interface.dart';

class WhatsappAccessibilityService {
  Future<String?> getPlatformVersion() {
    return WhatsappAccessibilityServicePlatform.instance.getPlatformVersion();
  }

  static Future<bool> requestAccessibilityPermission() async {
    return WhatsappAccessibilityServicePlatform.instance
        .requestAccessibilityPermission();
  }

  static Future<bool> isAccessibilityPermissionEnabled() async {
    return WhatsappAccessibilityServicePlatform.instance
        .isAccessibilityPermissionEnabled();
  }

  static Future<bool> setServiceEnabled(bool enable) async {
    return WhatsappAccessibilityServicePlatform.instance
        .setServiceEnabled(enable);
  }

  static Future<String> setCustomSuffix(String suffix) async {
    return WhatsappAccessibilityServicePlatform.instance
        .setCustomSuffix(suffix);
  }
}
