//
//  AuthViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 11.10.2020.
//

import UIKit

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allViewsInXibArray = Bundle.main.loadNibNamed("Auth", owner: self, options: nil)

        //If you only have one view in the xib and you set it's class to MyView class
        let myView = allViewsInXibArray?.first as! Auth

        //Set wanted position and size (frame)
        myView.frame = self.view.bounds

        //Add the view
        self.view.addSubview(myView)


        // Do any additional setup after loading the view.
    }
    


}
