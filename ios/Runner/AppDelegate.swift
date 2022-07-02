import UIKit
import Flutter
// import GoogleMaps // esto proviene del paquete de google maps.... https://pub.dev/packages/google_maps_flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // GMSServices.provideAPIKey("YOUR KEY HERE") // esto proviene del PAquete con el api key de google maps.... https://pub.dev/packages/google_maps_flutter
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
