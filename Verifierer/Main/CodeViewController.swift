//
//  CodeViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 13.10.2020.
//

import UIKit
import BarcodeScanner
import Alamofire


class CodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self

        present(viewController, animated: true, completion: nil)
    }

}

extension CodeViewController: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        //print(code)
        AF.request(NetworkService.BaseUrl + "product/" + code).validate().responseDecodable(of: ProductApi.self) { (response) in
//             debugPrint(response)
            if(response.response?.statusCode == 200) {
                
                guard let product = response.value else { return }
                NetworkService.product = product
                AF.download(NetworkService.BaseUrl + "image/" + NetworkService.product!.files[0].id).responseData { response in
    //              debugPrint(response)
                    if let data = response.value {
                        NetworkService.product_image = UIImage(data: data)
                    }
                    AF.request(NetworkService.BaseUrl + "product/byid/" + NetworkService.product!.id).validate().responseDecodable(of: ProductWithReviews.self) { (response) in
                      //  debugPrint(response)
                        guard let product = response.value else { return }
                       // print(product.rewiews)
                        NetworkService.product_reviews = product.rewiews
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let sceneDelegate = windowScene.delegate as? SceneDelegate
                          else {
                            return
                          }
                        sceneDelegate.rootViewController.showProductScreen()
                    }
                }                
            } else {
                let alert = UIAlertController(title: "Ошибка распознания товара", message: "Нет информации о товаре с кодом " + code, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

                window?.rootViewController?.present(alert, animated: true, completion: nil)
                controller.reset()
            }
            
    
        }
            
        
//        controller.reset()
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
        controller.reset()
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        sceneDelegate.rootViewController.switchToMainScreen()
        
        }
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//            let sceneDelegate = windowScene.delegate as? SceneDelegate
//          else {
//            return
//          }
//        sceneDelegate.rootViewController.switchToMainScreen()
    
    
    
}
