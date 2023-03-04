import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_accessibility_service/whatsapp_accessibility_service_method_channel.dart';

void main() {
  MethodChannelWhatsappAccessibilityService platform = MethodChannelWhatsappAccessibilityService();
  const MethodChannel channel = MethodChannel('whatsapp_accessibility_service');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
