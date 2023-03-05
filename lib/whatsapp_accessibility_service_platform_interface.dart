import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'whatsapp_accessibility_service_method_channel.dart';

abstract class WhatsappAccessibilityServicePlatform extends PlatformInterface {
  /// Constructs a WhatsappAccessibilityServicePlatform.
  WhatsappAccessibilityServicePlatform() : super(token: _token);

  static final Object _token = Object();

  static WhatsappAccessibilityServicePlatform _instance =
      MethodChannelWhatsappAccessibilityService();

  /// The default instance of [WhatsappAccessibilityServicePlatform] to use.
  ///
  /// Defaults to [MethodChannelWhatsappAccessibilityService].
  static WhatsappAccessibilityServicePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WhatsappAccessibilityServicePlatform] when
  /// they register themselves.
  static set instance(WhatsappAccessibilityServicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> requestAccessibilityPermission() {
    throw UnimplementedError(
        'requestAccessibilityPermission() has not been implemented.');
  }

  Future<bool> isAccessibilityPermissionEnabled() {
    throw UnimplementedError(
        'isAccessibilityPermissionEnabled() has not been implemented.');
  }

  Future<bool> setServiceEnabled(bool enable) {
    throw UnimplementedError('setServiceEnabled() has not been implemented.');
  }

  Future<String> getSuffix() {
    throw UnimplementedError('getSuffix() has not been implemented.');
  }

  Future<String> setCustomSuffix(String suffix) {
    throw UnimplementedError('setCustomSuffix() has not been implemented.');
  }
}
