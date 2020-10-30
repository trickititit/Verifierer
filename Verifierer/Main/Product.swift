//
//  Product.swift
//  Verifierer
//
//  Created by Георгий Андреев on 13.10.2020.
//

import UIKit

class Product: UIView {


    @IBOutlet weak var productInfoTable: UITableView!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var desc: UITextView!

    @IBOutlet weak var reviews: UICollectionView!
    
    @IBOutlet weak var reviewsLayout: UICollectionViewFlowLayout!
    @IBAction func addReview(_ sender: UIButton) {
//        print("fdsafasdfas")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        sceneDelegate.rootViewController.showAddReviewScreen()
    }
    
    @IBAction func back(_ sender: UIButton) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        sceneDelegate.rootViewController.switchToMainScreen()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
