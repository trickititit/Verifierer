//
//  LoginViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 09.10.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setIcon(iconName: "mail", input: email)
//        setIcon(iconName: "lock", input: passwordInput)
           
        // Do any additional setup after loading the view.
        
        let allViewsInXibArray = Bundle.main.loadNibNamed("Login", owner: self, options: nil)

        //If you only have one view in the xib and you set it's class to MyView class
        let myView = allViewsInXibArray?.first as! Login

        //Set wanted position and size (frame)
        myView.frame = self.view.bounds

        //Add the view
        self.view.addSubview(myView)
    }
    
    @objc
    private func login() {
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        sceneDelegate.rootViewController.switchToMainScreen()
    }
    
    func setIcon (iconName: String, input: UITextField) {
        let padding = 20
        input.layer.cornerRadius = input.frame.size.height / 2
        input.clipsToBounds = true
        input.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView()
        let image = UIImage(systemName: iconName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.image = image
        if (padding > 0) {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView()
            paddingView.translatesAutoresizingMaskIntoConstraints = false
            paddingView.widthAnchor.constraint(equalToConstant: CGFloat(padding)).isActive = true
            paddingView.heightAnchor.constraint(equalToConstant: CGFloat(padding)).isActive = true
            stackView.addArrangedSubview(paddingView)
            stackView.addArrangedSubview(imageView)
            input.leftView = stackView
        } else {
            input.leftView = imageView
        }
    
    }
    
}
