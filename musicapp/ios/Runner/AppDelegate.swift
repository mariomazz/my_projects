import UIKit
import Flutter
import FirebaseCore
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    UIApplication.shared.beginReceivingRemoteControlEvents()
      
      do {
          try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
          print("Playback OK")
          try AVAudioSession.sharedInstance().setActive(true)
          print("Session is Active")
      } catch {
          print(error)
      }
     /* let audioSession = AVAudioSession.sharedInstance()
          do {
              // Set the audio session category, mode, and options.
              try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
          } catch {
              print("Failed to set audio session category.")
          }*/
          
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

