import Flutter
import AVFAudio
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: "bladderly", binaryMessenger: controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            
            guard call.method == "checkLiveListen" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            result(self?.checkLiveListen(recordingSession: AVAudioSession.sharedInstance()))
            
        })
        
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func checkLiveListen(recordingSession:AVAudioSession) -> Bool{
        guard recordingSession.availableInputs != nil else {
            return false
        }
        
        return  recordingSession.currentRoute.outputs.contains { $0.portType == .bluetoothHFP }
    }
}
