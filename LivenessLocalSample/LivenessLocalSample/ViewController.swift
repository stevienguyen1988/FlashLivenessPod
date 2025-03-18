

import UIKit
import FlashLiveness
import SVProgressHUD
class ViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var scanBtn: UIButton!
    var image:UIImage?
    var clienttransaction = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func registerFace(_ sender: Any) {
        
//        if #available(iOS 13.0, *) {
//            Task {
//                do {
//                  //  scanBtn.isEnabled = false
//                    let data = try await IDCardReaderManager.shared.initTransaction()
//                    clienttransaction = data.data
//                    let parsedInformation = try await IDCardReaderManager.shared.readIDCard(cardId: "098011462",
//                                                                                            dateOfBirth: "10/03/1998",
//                                                                                            dateOfExpiry: "10/03/2038", transactionId: data.data)
//                    let result = Data(base64Encoded: parsedInformation.data!.faceImage)
//                    let response = try await Networking.shared.registerFace(faceImage:UIImage(data: result!)!)
//      //              scanBtn.isEnabled = true
//                }catch let error as CardValidationError {
//       //             scanBtn.isEnabled = true
//                    let alert = UIAlertController(title: "API Error", message: error.localizedDescription, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .destructive))
//                    self.present(alert, animated: true)
//
//                } catch let error as NFCPassportReaderError {
//            //        scanBtn.isEnabled = true
//                    let alert = UIAlertController(title: "ReadCard Error", message: error.localizedDescription, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .destructive))
//                    self.present(alert, animated: true)
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        Task{
            do{
                let response = try await Networking.shared.registerFace(faceImage:image!)
                print(response)
                if response.status == 200{

                }else{

                }
                
            }catch{
   
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @available(iOS 13.0, *)
    @IBAction func livenessBtnTapped(_ sender: Any) {
        if #available(iOS 15.0, *) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LivenessVC") as! LivenessVC
            vc.clientTransaction = self.clienttransaction
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }

    @IBAction func livenessFlashBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LivenessFlashVC") as! LivenessFlashVC
        vc.clientTransaction = self.clienttransaction
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
