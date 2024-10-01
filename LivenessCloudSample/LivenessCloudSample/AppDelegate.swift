//
//  AppDelegate.swift
//  LivenessCloudSample
//

//

import UIKit
import FlashLiveness
import IDCardReader
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        if #available(iOS 13.0, *) {
//            let privateUrl = Bundle.main.url(forResource: "com.qts.test.idcard", withExtension: "txt")
//            let publicUrl = Bundle.main.url(forResource: "eid.idcard", withExtension: "txt")
//            do {
//                let privateKey = try! String(contentsOf: privateUrl!, encoding: .utf8)
//                let publicKey = try! String(contentsOf: publicUrl!, encoding: .utf8)
//                IDCardReaderManager.shared.setup(serverUrl: "https://ekyc-sandbox.eidas.vn/ekyc", appId: "com.pvcb", publicKey: publicKey, privateKey: privateKey)
//                IDCardReaderManager.shared.setLocalizeTexts(reading: "Reading")
//                IDCardReaderManager.shared.setLocalizeTexts(requestPresentCard: "Vui lòng đưa CCCD vào",
//                                                            authenticating: "Đang xác thực",
//                                                            reading: "Đang đọc",
//                                                            errorReading: "Lỗi khi đọc thẻ",
//                                                            successReading: "Đọc thẻ thành công",
//                                                            retry: "Đang thử lại")
//                
//                
//            } catch {
//                print(error)
//            }
//        }else {
//            
//        }
//        if #available(iOS 13.0, *) {
//            Task {
//                do {
//                    let result = try await IDCardReaderManager.shared.registerDeviceToken()
//                    print(result)
//                } catch {
//
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//        }
        
        
        
        let urlPrivate = Bundle.main.url(forResource: "com.qts.test", withExtension: "txt")
        let urlPublic = Bundle.main.url(forResource: "eid", withExtension: "txt")
        let privateKey = try! String(contentsOf: urlPrivate!, encoding: .utf8)
        let publicKey = try! String(contentsOf: urlPublic!, encoding: .utf8)
        Networking.shared.setup(appId: "com.pvcb", logLevel: .debug, url: "https://ekyc-sandbox.eidas.vn/face-matching", publicKey: publicKey, privateKey: privateKey)
        Networking.shared.resetDeviceInfo()
        let resposne = Networking.shared.generateDeviceInfor()
        print(resposne)
        
//        Networking.shared.resetDeviceInfo()
//        let urlPrivate = Bundle.main.url(forResource: "com.qts.test", withExtension: "txt")
//        let urlPublic = Bundle.main.url(forResource: "eid", withExtension: "txt")
//        let privateKey = try! String(contentsOf: urlPrivate!, encoding: .utf8)
//        let publicKey = try! String(contentsOf: urlPublic!, encoding: .utf8)
//        Networking.shared.setup(appId: "com.pvcb", logLevel: .debug, url: "https://ekyc-sandbox.eidas.vn/face-matching", publicKey: publicKey, privateKey: privateKey)
//        let resposne = Networking.shared.generateDeviceInfor(deviceId: "testtest")
//        print(resposne)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

