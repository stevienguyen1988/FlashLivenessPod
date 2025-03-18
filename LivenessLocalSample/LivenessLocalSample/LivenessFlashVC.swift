//
//  LivenessFlashVC.swift
//  HostApp
//

//

import UIKit
import FlashLiveness
class LivenessFlashVC: UIViewController {
    var livenessDetector: LivenessUtilityDetector?
    
    @IBOutlet weak var previewView: UIView!
    var transactionId = ""
    var clientTransaction = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.livenessDetector = LivenessUtil.createLivenessDetector(previewView: self.previewView, mode: .offline, delegate: self)
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
        do {
            try self.livenessDetector?.getVerificationRequiresAndStartSession(transactionId: self.transactionId)
        } catch{
            
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

extension LivenessFlashVC: LivenessUtilityDetectorDelegate {
    func liveness(_ liveness: LivenessUtilityDetector, didFail withError: LivenessError) {
        print("Liveness failed because of \(withError)")
    }
    
    func liveness(_ liveness: LivenessUtilityDetector, didFinishWithFaceImages images: LivenessFaceImages) {
        images.images?.forEach { image in
            UIImageWriteToSavedPhotosAlbum(image.image, nil, nil, nil)
        }
        let alert = UIAlertController(title: "Response", message: "Thành công", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            try? self.livenessDetector?.getVerificationRequiresAndStartSession()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
