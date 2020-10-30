//
//  Register.swift
//  Verifierer
//
//  Created by Георгий Андреев on 11.10.2020.
//

import UIKit

class Register: UIView {
    
    var delegate:RegisterDelegate?
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var gendersInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var createAcc: UIButton!    
    
    @IBAction func createAcc(_ sender: UIButton) {
        delegate?.send()
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

protocol RegisterDelegate {
    func send()
}
