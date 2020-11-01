//
//  AddReviewViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 24.10.2020.
//

import UIKit
import FloatRatingView
import Alamofire

class AddReviewViewController: UIViewController {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    var newView = AddReview()
    var raringValue = 0
    var photo = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allViewsInXibArray = Bundle.main.loadNibNamed("AddReview", owner: self , options: nil)

        //If you only have one view in the xib and you set it's class to MyView class
        self.newView = allViewsInXibArray?.first as! AddReview

        self.newView.frame = self.view.bounds
        
        self.view.addSubview(self.newView)
        self.newView.floatRating.delegate = self
        self.newView.delegate = self
        
        self.newView.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.newView.delegate = self
    }

}

extension AddReviewViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.newView.image.image = image
    }
}


extension AddReviewViewController: FloatRatingViewDelegate {
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
//        print(rating)
        self.newView.rating.text = String(Int(rating))
        self.raringValue = Int(rating)
    }
}

extension AddReviewViewController: AddReviewDelegate {
    func send() {
        
        let strBase64 = self.newView.image.image!.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        
        let review = ReviewForm(productId: NetworkService.product!.id, bonusShopId: NetworkService.shopID, review: self.newView.reviewText.text, stars: self.raringValue, photo: strBase64)
        
        AF.request(NetworkService.BaseUrl + "rewiews/add",
                   method: .post,
                   parameters: review,
                   encoder: JSONParameterEncoder.default).validate().response { response in
//                    debugPrint(response)
                    if(response.response?.statusCode == 200) {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let sceneDelegate = windowScene.delegate as? SceneDelegate
                          else {
                            return
                          }
                        sceneDelegate.rootViewController.showSplashScreen()
                    } else {
                        
                    }
        }
    }
}
