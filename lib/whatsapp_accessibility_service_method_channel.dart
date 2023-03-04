import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'whatsapp_accessibility_service_platform_interface.dart';

/// An implementation of [WhatsappAccessibilityServicePlatform] that uses method channels.
class MethodChannelWhatsappAccessibilityService
    extends WhatsappAccessibilityServicePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel('jagrit/whatsapp_accessibility_service');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// request accessibility permission
  /// it will open the accessibility settings page and return `true` once the permission granted.
  @override
  Future<bool> requestAccessibilityPermission() async {
    try {
      return await methodChannel.invokeMethod('requestAccessibilityPermission');
    } on PlatformException catch (error) {
      log(error.toString());
      return Future.value(false);
    }
  }

  /// check if accessibility permission is enabled
  @override
  Future<bool> isAccessibilityPermissionEnabled() async {
    try {
      return await methodChannel
          .invokeMethod('isAccessibilityPermissionEnabled');
    } on PlatformException catch (error) {
      log(error.toString());
      return false;
    }
  }

  @override
  Future<bool> setServiceEnabled(bool enable) async {
    try {
      var arguments = {"enable": enable};
      bool isActive =
          await methodChannel.invokeMethod('setServiceEnabled', arguments);
      log(isActive.toString());
      return isActive;
    } on PlatformException catch (error) {
      log(error.toString());
      return false;
    }
  }

  @override
  Future<String> setCustomSuffix(String suffix) async {
    try {
      var arguments = {"suffix": suffix};
      String suffixReceived =
          await methodChannel.invokeMethod('setCustomSuffix', arguments);
      log(suffix.toString());
      return suffixReceived;
    } on PlatformException catch (error) {
      log(error.toString());
      return "false";
    }
  }
}
