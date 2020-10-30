//
//  MainViewController.swift
//  RootControllerNavigation
//
//  Created by Stanislav Ostrovskiy on 12/5/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit
import Alamofire

class MainNavigationController: UINavigationController { }

class MainViewController: UIViewController {
    
    @objc
    private func logout() {	
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        sceneDelegate.rootViewController.switchToLogout()
    }
    
    @objc
    func showActivityScreen(animated: Bool = true) {
        let activityViewController = ActivityViewController()
        navigationController?.pushViewController(activityViewController, animated: animated)
    }


let cellID = "SellerCell"
let insents = UIEdgeInsets(top: 10, left: 0, bottom: 25, right: 0)
var newView = Main()
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    let allViewsInXibArray = Bundle.main.loadNibNamed("Main", owner: self, options: nil)

    //If you only have one view in the xib and you set it's class to MyView class
    self.newView = allViewsInXibArray?.first as! Main

    //Set wanted position and size (frame)
    self.newView.frame = self.view.bounds

    //Add the view
    self.view.addSubview(self.newView)
    collectionViewSetup()
}

func collectionViewSetup() {
    self.newView.sellersCollection.delegate = self
    self.newView.sellersCollection.dataSource = self
    self.newView.sellersCollection.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
//        collectionView.register(PhotCell.self, forCellWithReuseIdentifier: cellID)
//        layout.itemSize = CGSize
//        layout.minimumLineSpacing
//        layout.sectionInset
}

override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    self.newView.sellersLayout.invalidateLayout()
}

@objc func tap(_ sender: UITapGestureRecognizer) {
    let location = sender.location(in: self.newView.sellersCollection)
    let indexPath = self.newView.sellersCollection.indexPathForItem(at: location)   
    if let index = indexPath?.row {
        print(NetworkService.user!.bonuses[index].bonusShop.id)
        NetworkService.shopID = NetworkService.user!.bonuses[index].bonusShop.id
//        print(index)
//      print("Got clicked on index: \(index)!")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        sceneDelegate.rootViewController.showCodeScreen	()
   }
}

}

extension MainViewController: UICollectionViewDelegate {

}

extension MainViewController: UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        as? SellerCell else { return UICollectionViewCell() }
    let index = indexPath.item
    let bonus = NetworkService.user!.bonuses[index]
    cell.setup2(bonus: bonus)
    cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    return cell
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return NetworkService.shops!.count
}

func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}
}

extension MainViewController    : UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // 10 - инсет, 5 - это то число, которое будет умножаться на 2 (между двумя столбцами)
    let width: CGFloat = collectionView.frame.width - 20
    let height: CGFloat = collectionView.frame.width / 3
    return CGSize(width: width, height: height)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return insents
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
}
}
