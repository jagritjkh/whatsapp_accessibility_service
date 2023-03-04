import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:whatsapp_accessibility_service/whatsapp_accessibility_service.dart';
import 'package:whatsapp_accessibility_service/whatsapp_accessibility_service_method_channel.dart';
import 'package:whatsapp_accessibility_service/whatsapp_accessibility_service_platform_interface.dart';

class MockWhatsappAccessibilityServicePlatform
    with MockPlatformInterfaceMixin
    implements WhatsappAccessibilityServicePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> isAccessibilityPermissionEnabled() => Future.value(false);

  @override
  Future<bool> requestAccessibilityPermission() => Future.value(false);

  @override
  Future<bool> setServiceEnabled(bool toActive) => Future.value(toActive);

  @override
  Future<String> setCustomSuffix(String suffix) => Future.value(suffix);
}

void main() {
  final WhatsappAccessibilityServicePlatform initialPlatform =
      WhatsappAccessibilityServicePlatform.instance;

  test('$MethodChannelWhatsappAccessibilityService is the default instance',
      () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelWhatsappAccessibilityService>());
  });

  test('getPlatformVersion', () async {
    WhatsappAccessibilityService whatsappAccessibilityServicePlugin =
        WhatsappAccessibilityService();
    MockWhatsappAccessibilityServicePlatform fakePlatform =
        MockWhatsappAccessibilityServicePlatform();
    WhatsappAccessibilityServicePlatform.instance = fakePlatform;

    expect(await whatsappAccessibilityServicePlugin.getPlatformVersion(), '42');
  });
}
