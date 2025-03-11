import Flutter
import UIKit
import AVFoundation 

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let bluetoothChannel = FlutterMethodChannel(name: "bluetooth_hfp_checker",
                                                binaryMessenger: controller.binaryMessenger)
    
    bluetoothChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "isBluetoothHFPConnected" {
        result(self.isBluetoothHFPConnected())  // HFP 연결 여부 확인
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // ✅ Hands-Free Profile (HFP) 연결 여부 확인 함수
 private func isBluetoothHFPConnected() -> Bool {
    let session = AVAudioSession.sharedInstance()
    
    do {
        try session.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth, .allowBluetoothA2DP])
        try session.setActive(true)  // ✅ 세션 활성화
    } catch {
        print("⚠️ AVAudioSession 설정 실패: \(error.localizedDescription)")
        return false
    }

    let availableInputs = session.availableInputs ?? []
    
    for input in availableInputs {
        print("🔍 Available input: \(input.portType.rawValue)")  // ✅ 디버깅 로그 추가
        if input.portType == .bluetoothHFP {
            return true
        }
    }
    
    return false
}
}
