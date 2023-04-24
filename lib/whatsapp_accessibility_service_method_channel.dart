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

  /// method channel method which connects with native to request accessibility permission
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

  /// method channel method which connects with native to check if accessibility permission is enabled
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

  /// method channel method which connects with native to set service enabled/disabled
  @override
  Future<bool> setServiceEnabled(bool enable) async {
    try {
      var arguments = {"enable": enable};
      return await methodChannel.invokeMethod('setServiceEnabled', arguments);
    } on PlatformException catch (error) {
      log(error.toString());
      return false;
    }
  }

  @override
  Future<String> getSuffix() async {
    try {
      return await methodChannel.invokeMethod('getSuffix');
    } on PlatformException catch (error) {
      log(error.toString());
      return "false";
    }
  }

  @override
  Future<String> setCustomSuffix(String suffix) async {
    try {
      var arguments = {"suffix": suffix};
      return await methodChannel.invokeMethod('setCustomSuffix', arguments);
    } on PlatformException catch (error) {
      log(error.toString());
      return "false";
    }
  }

  @override
  Future<String> setMessage(String message) async {
    try {
      var arguments = {"message": message};
      return await methodChannel.invokeMethod('setMessage', arguments);
    } on PlatformException catch (error) {
      log(error.toString());
      return "false";
    }
  }
}
