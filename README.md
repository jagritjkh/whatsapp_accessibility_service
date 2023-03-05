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

Inside AndroidManifest add this to bind your accessibility service with your application

```xml
    .
    .
    <service
        android:name="com.jagrit.whatsapp_accessibility_service.WhatsappAccessibilityService"
        android:exported="false"
        android:permission="android.permission.BIND_ACCESSIBILITY_SERVICE">
        <intent-filter>
            <action android:name="android.accessibilityservice.AccessibilityService" />
        </intent-filter>
        <meta-data
            android:name="android.accessibilityservice"
            android:resource="@xml/accessibilityservice" />
    </service>
    .
    .
</application>
```

Create Accesiblity config file named `accessibilityservice.xml` inside `res/xml` and add the following code inside it:
```xml
<?xml version="1.0" encoding="utf-8"?>
<accessibility-service xmlns:android="http://schemas.android.com/apk/res/android"
    android:accessibilityEventTypes="typeWindowsChanged|typeWindowStateChanged|typeWindowContentChanged"
    android:accessibilityFeedbackType="feedbackVisual"
    android:notificationTimeout="300"
    android:accessibilityFlags="flagDefault|flagIncludeNotImportantViews|flagRequestTouchExplorationMode|flagRequestEnhancedWebAccessibility|flagReportViewIds|flagRetrieveInteractiveWindows"
    android:canRetrieveWindowContent="true"
>
</accessibility-service>
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

# to enable/disable service
```
await WhatsappAccessibilityService.setServiceEnabled(true);
await WhatsappAccessibilityService.setServiceEnabled(false);
```

# to set custom suffix (on which auto click will work)
```
await WhatsappAccessibilityService.setCustomSuffix("by Jagrit");
await WhatsappAccessibilityService.setCustomSuffix("     ");
```