//
//  Profile.swift
//  Verifierer
//
//  Created by Георгий Андреев on 23.10.2020.
//

import UIKit
import Alamofire

class Profile: UIView {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var table: UITableView!
    
    
    @IBAction func logout(_ sender: UIButton) {
        
        AF.request(NetworkService.BaseUrl + "user/logout"
                   ).validate().response { response in
//                    debugPrint(response)
//                    print(response.response?.statusCode)
                    if(response.response?.statusCode == 200) {
                        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let sceneDelegate = windowScene.delegate as? SceneDelegate
                          else {
                            return
                          }
                        sceneDelegate.rootViewController.showAuthScreen()
                    } else {
                        let alert = UIAlertController(title: "Ошибка выхода", message: "Чтото не так", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

                        window?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                    
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
