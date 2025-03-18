//
//  LivenessVC.swift
//  HostApp
//
//  Created by admin on 04/03/2024.
//

import UIKit
//import LivenessCloud
import QTSLiveness

@available(iOS 15.0, *)
class LivenessVC: UIViewController {

    @IBOutlet weak var previewView: UIView!
    var livenessDetector: QTSLivenessDetector?
    var transactionId = ""
    var clientTransaction = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.livenessDetector = QTSDepthLivenessDetector.init(
            previewView: self.previewView,
            threshold: .low,
//            smallFaceThreshold: 0.25,
            debugging: false,
            opacityOval: 0.6,
            livenessMode: .local,
//            localLivenessThreshold: 0.93,
            calculationMode: .combine
        )
        self.livenessDetector?.delegate = self
//        Task{
//            do{
//                try await Networking.shared.updateloadImage(image: UIImage.init(named: "alpha.png")!, threshold: 1, thema: 1)
//            }catch{
//
//            }
//        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task{
            do{
                try livenessDetector?.getVerificationRequiresAndStartSession(transactionId: transactionId)
            }catch{
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        livenessDetector?.stopLiveness()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

@available(iOS 15.0, *)
extension LivenessVC: QTSLivenessUtilityDetectorDelegate {
    func liveness(liveness: QTSLivenessDetector, didFinishLocalLiveness score: Float, maxtrix: [Float], image: UIImage, thermal_image: UIImage, videoURL: URL?) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        UIImageWriteToSavedPhotosAlbum(thermal_image, nil, nil, nil)
        let alert = UIAlertController(title: "Response", message: "Thành công: score=\(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            try? self.livenessDetector?.getVerificationRequiresAndStartSession()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
