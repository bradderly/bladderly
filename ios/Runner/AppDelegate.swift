import Flutter
import AVFAudio
import UIKit
import notifly_sdk

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        UNUserNotificationCenter.current().delegate = self
        
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
    
    
    override func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        Notifly.application(application,
                            didFailToRegisterForRemoteNotificationsWithError: error)
        super.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Notifly.application(application,
                            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    override func userNotificationCenter(_ notificationCenter: UNUserNotificationCenter,
                                         didReceive response: UNNotificationResponse,
                                         withCompletionHandler completion: @escaping () -> Void)
    {
        Notifly.userNotificationCenter(notificationCenter,
                                       didReceive: response)
        super.userNotificationCenter(notificationCenter, didReceive: response, withCompletionHandler: completion)
    }
    
    override func userNotificationCenter(_ notificationCenter: UNUserNotificationCenter,
                                         willPresent notification: UNNotification,
                                         withCompletionHandler completion: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        Notifly.userNotificationCenter(notificationCenter,
                                       willPresent: notification,
                                       withCompletionHandler: completion)
        super.userNotificationCenter(notificationCenter, willPresent: notification, withCompletionHandler: completion)
    }
    
    func checkLiveListen(recordingSession:AVAudioSession) -> Bool{
        guard recordingSession.availableInputs != nil else {
            return false
        }
        
        return  recordingSession.currentRoute.outputs.contains { $0.portType == .bluetoothHFP }
    }
}
