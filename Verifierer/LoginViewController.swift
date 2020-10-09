//
//  LoginViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 09.10.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setIcon(iconName: "mail", input: emailInput)
        setIcon(iconName: "lock", input: passwordInput)
           
        // Do any additional setup after loading the view.
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
