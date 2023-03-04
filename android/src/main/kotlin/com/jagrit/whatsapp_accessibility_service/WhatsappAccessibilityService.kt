package com.jagrit.whatsapp_accessibility_service

import android.accessibilityservice.AccessibilityService
import android.annotation.TargetApi
import android.os.Build
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo

@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
class WhatsappAccessibilityService : AccessibilityService() {

    companion object {
        var isActive: Boolean = false
        var suffix: String = "          "
    }

    override fun onAccessibilityEvent(accessibilityEvent: AccessibilityEvent) {
        try {
            if (isActive) {
                if (rootInActiveWindow == null) {
                    return
                }
                val rootInActiveWindow = AccessibilityNodeInfo.obtain(
                    rootInActiveWindow
                )

                // text field id
                val messageNodeInfoList =
                    rootInActiveWindow.findAccessibilityNodeInfosByViewId("com.whatsapp:id/entry")
                if (messageNodeInfoList == null || messageNodeInfoList.isEmpty()) {
                    return
                }
                val textField = messageNodeInfoList[0]
                if (textField == null || textField.text.length == 0 || !textField.text.toString()
                        .endsWith(suffix)
                ) {
                    return
                }

                // Whatsapp send button id
                val sendMessageNodeInfoList =
                    rootInActiveWindow.findAccessibilityNodeInfosByViewId("com.whatsapp:id/send")
                if (sendMessageNodeInfoList == null || sendMessageNodeInfoList.isEmpty()) {
                    return
                }
                val sendMessageButton = sendMessageNodeInfoList[0]
                if (!sendMessageButton.isVisibleToUser) {
                    return
                }

                // Now fire a click on the send button
                sendMessageButton.performAction(AccessibilityNodeInfo.ACTION_CLICK)

                // Now go back to your app by clicking on the Android back button twice:
                // First one to leave the conversation screen
                // Second one to leave whatsapp
                Thread.sleep(1000) // hack for certain devices in which the immediate back click is too fast to handle
                performGlobalAction(GLOBAL_ACTION_BACK)
                Thread.sleep(1000) // same hack as above
                performGlobalAction(GLOBAL_ACTION_BACK)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun onInterrupt() {
        System.out.println("Whatsapp Accessibility Service onInterrupt")
    }
}
