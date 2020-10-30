//
//  SplashViewController.swift
//  RootControllerNavigation
//
//  Created by Stanislav Ostrovskiy on 12/5/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.addSubview(activityIndicator)
        
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        //let dispatchGroup = DispatchGroup()
        activityIndicator.startAnimating()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
    
//        dispatchGroup.enter()
//        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
            AF.request(NetworkService.BaseUrl + "users/me").validate().responseDecodable(of: User.self) { (response) in
//                debugPrint(response)
                if(response.response?.statusCode == 200) {
                    guard let user = response.value else { return }
                    NetworkService.user = user
                    AF.download(NetworkService.BaseUrl + "users/" + NetworkService.user!.id + "/avatar").responseData { response in
//                        debugPrint(response)
                        if let data = response.value {
                            NetworkService.avatar = UIImage(data: data)
                        }

                            AF.request(NetworkService.BaseUrl + "bonusshops").validate().responseDecodable(of: [BonusShop].self) { (response) in
//                                debugPrint(response)
                                if(response.response?.statusCode == 200) {
                                    guard let shops = response.value else { return }
                                    NetworkService.shops = shops
                                } else {
                                    
                                }
//                                dispatchGroup.leave()
                                AF.request(NetworkService.BaseUrl + "history").validate().responseDecodable(of: HistoryRequest.self) { (response) in
//                                    debugPrint(response)
                                    guard let history = response.value else { return }
                                    NetworkService.history = history
                                    
                                    self.activityIndicator.stopAnimating()
                                    sceneDelegate.rootViewController.switchToMainScreen()
                                }
                              }
                        }
                    
                } else {
                    self.activityIndicator.stopAnimating()
                    sceneDelegate.rootViewController.showAuthScreen()                
                }
              }
            
//            sceneDelegate.rootViewController.switchToMainScreen()
            
        } else {
            self.activityIndicator.stopAnimating()
            sceneDelegate.rootViewController.showAuthScreen()
        }
                
        
//        dispatchGroup.notify(queue: .main) {
//            // process results of 2 service calls
//        }
        
    }
}
