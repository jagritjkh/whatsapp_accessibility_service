# whatsapp_accessibility_service

WhatsappAccessibilityService is a plugin for interacting with Whatsapp Accessibility Service in Android which activates auto click of send button.

Accessibility services are intended to assist users with disabilities in using Android devices and apps, or I can say to get android os events like keyboard key press events or notification received events etc.
for more info check [Accessibility Service](https://developer.android.com/reference/android/accessibilityservice/AccessibilityService)

## Getting Started

To use this package, add `whatsapp_accessibility_service` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Add dependency
```
dependencies:
  whatsapp_accessibility_service: ^0.0.1
```

## Import
```
import 'package:whatsapp_accessibility_service/whatsapp_accessibility_service.dart'
```

## Usage
# to request permission
```
bool status = await WhatsappAccessibilityService.requestAccessibilityPermission();
```

# to check if accessibility permission is enabled
```
bool status = await WhatsappAccessibilityService.isAccessibilityPermissionEnabled();
```

# to toggle service
```
await WhatsappAccessibilityService.toggleService();
```