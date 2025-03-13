package com.soundable.diaryandroid.us

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle

class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.soundable.diaryandroid.us/customBuild"
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBuildNumber") {
                // Return the custom build number from BuildConfig
                result.success(BuildConfig.build)  // `build` is the custom field you defined
            } else {
                result.notImplemented()
            }
        }
    }
}
