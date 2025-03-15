package com.soundable.diaryandroid.us

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.soundable.diaryandroid.us/customBuild"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine.run {
            GeneratedPluginRegistrant.registerWith(this)
            MethodChannel(
                flutterEngine.dartExecutor,
                CHANNEL
            ).setMethodCallHandler { call, result ->
                if (call.method == "getBuildNumber") {
                    // Return the custom build number from BuildConfig
                    result.success(BuildConfig.build)  // `build` is the custom field you defined
                } else {
                    result.notImplemented()
                }
            }
        }
    }
}
