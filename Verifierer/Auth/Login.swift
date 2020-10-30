//
//  Login.swift
//  Verifierer
//
//  Created by Георгий Андреев on 10.10.2020.
//

import UIKit
import Alamofire

class Login: UIView {

    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

//    let BaseUrl = "http://10.10.3.61:5555/api/v1/"
    
    struct LoginForm: Encodable {
        let login: String
        let password: String
        let rememberMe: Bool
    }
    
    @IBAction func Login(_ sender: UIButton) {
        
        let login = LoginForm(login: mail.text!, password: password.text!, rememberMe: true)

        AF.request(NetworkService.BaseUrl + "user/login",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).validate().response { response in
//                    debugPrint(response)
//                    print(response.response?.statusCode)
                    if(response.response?.statusCode == 200) {
                        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let sceneDelegate = windowScene.delegate as? SceneDelegate
                          else {
                            return
                          }
                        sceneDelegate.rootViewController.showSplashScreen()
                    } else {
                        let alert = UIAlertController(title: "Ошибка авторизации", message: "Не верный логин или пароль", preferredStyle: .alert)

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
