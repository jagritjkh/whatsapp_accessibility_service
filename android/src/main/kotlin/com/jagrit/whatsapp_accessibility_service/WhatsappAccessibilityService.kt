package com.jagrit.whatsapp_accessibility_service

import android.accessibilityservice.AccessibilityService
import android.annotation.TargetApi
import android.os.Build
import android.os.Bundle
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo

@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
class WhatsappAccessibilityService : AccessibilityService() {

    companion object {
        var isActive: Boolean = false
        var suffix: String = "          "
        var message: String = ""
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

                if (message.length == 0 || !message.endsWith(suffix)) {
                    return
                }

                // caption field id
                val captionNodeInfoList =
                    rootInActiveWindow.findAccessibilityNodeInfosByViewId("com.whatsapp:id/caption")
                if (captionNodeInfoList != null && !captionNodeInfoList.isEmpty()) {
                    val captionField = captionNodeInfoList[0]
                    if (captionField != null) {
                        val sendMediaNodeInfoList =
                            rootInActiveWindow.findAccessibilityNodeInfosByViewId("com.whatsapp:id/send")
                        if (sendMediaNodeInfoList != null && !sendMediaNodeInfoList.isEmpty()) {
                            val sendMediaButton = sendMediaNodeInfoList[0]
                            if (sendMediaButton.isVisibleToUser) {
                                sendMediaButton.performAction(AccessibilityNodeInfo.ACTION_CLICK)
                            }
                        }
                    }
                }

                val shareWithInfoList =
                    rootInActiveWindow.findAccessibilityNodeInfosByViewId("android:id/button1")
                if (shareWithInfoList != null && !shareWithInfoList.isEmpty()) {
                    val okButton = shareWithInfoList[0]
                    if (okButton.isVisibleToUser) {
                        okButton.performAction(AccessibilityNodeInfo.ACTION_CLICK)
                    }
                }


                // text field id
                val messageNodeInfoList =
                    rootInActiveWindow.findAccessibilityNodeInfosByViewId("com.whatsapp:id/entry")
                if (messageNodeInfoList == null || messageNodeInfoList.isEmpty()) {
                    return
                }
                val textField = messageNodeInfoList[0]
                if (textField == null) {
                    return
                }

                val arguments = Bundle();
                arguments.putCharSequence(
                    AccessibilityNodeInfo.ACTION_ARGUMENT_SET_TEXT_CHARSEQUENCE,
                    message
                );
                textField.performAction(AccessibilityNodeInfo.ACTION_SET_TEXT, arguments);

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
