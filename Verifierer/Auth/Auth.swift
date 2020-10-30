//
//  Auth.swift
//  Verifierer
//
//  Created by Георгий Андреев on 11.10.2020.
//

import UIKit

class Auth: UIView {

    @IBAction func goToRegistr(_ sender: UIButton) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        sceneDelegate.rootViewController.showRegisterScreen()
    }
    @IBAction func goToLogin(_ sender: UIButton) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        sceneDelegate.rootViewController.showLoginScreen()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
