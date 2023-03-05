package com.jagrit.whatsapp_accessibility_service

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


private const val CHANNEL_NAME = "jagrit/whatsapp_accessibility_service"

private const val REQUEST_CODE_FOR_ACCESSIBILITY = 167

/** WhatsappAccessibilityServicePlugin */
class WhatsappAccessibilityServicePlugin : FlutterPlugin, ActivityAware, MethodCallHandler,
    PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context

    private var mActivity: Activity? = null

    private lateinit var pendingResult: Result

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext()
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "isAccessibilityPermissionEnabled" -> {
                result.success(Utils.isAccessibilitySettingsOn(context))
            }
            "requestAccessibilityPermission" -> {
                val suffix = call.argument<String>("suffix")
                WhatsappAccessibilityService.suffix = suffix
                val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                mActivity?.startActivityForResult(intent, REQUEST_CODE_FOR_ACCESSIBILITY)
            }
            "setServiceEnabled" -> {
                val enable = call.argument<Boolean>("enable")
                if (enable == null) {
                    return
                }
                WhatsappAccessibilityService.isActive = enable
                result.success(WhatsappAccessibilityService.isActive)
            }
            "getSuffix" -> {
                result.success(WhatsappAccessibilityService.suffix)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == REQUEST_CODE_FOR_ACCESSIBILITY) {
            if (resultCode == Activity.RESULT_OK) {
                pendingResult.success(true)
            } else if (resultCode == Activity.RESULT_CANCELED) {
                pendingResult.success(Utils.isAccessibilitySettingsOn(context))
            } else {
                pendingResult.success(false)
            }
            return true
        }
        return false
    }

    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        this.mActivity = binding.getActivity()
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.mActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        this.mActivity = null
    }
}
