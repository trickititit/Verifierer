//
//  HomeViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 09.10.2020.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    var newView = Home()
    let cellID = "HistoryCell"
    let insents = UIEdgeInsets(top: 10, left: 0, bottom: 25, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allViewsInXibArray = Bundle.main.loadNibNamed("Home", owner: self, options: nil)
        //If you only have one view in the xib and you set it's class to MyView class
        self.newView = allViewsInXibArray?.first as! Home
        //Set wanted position and size (frame)
        self.newView.frame = self.view.bounds
        //Add the view
        self.view.addSubview(self.newView)
        self.newView.hello.text = "Привет " + NetworkService.user!.firstName
        self.newView.bonus.text = "На Вашем счету " + String(NetworkService.user!.bonusesSummary) + " бонусов."
        self.newView.avatar.image = NetworkService.avatar
        
        self.newView.avatar.layer.borderWidth = 1
        self.newView.avatar.layer.masksToBounds = false
        self.newView.avatar.layer.borderColor = UIColor.black.cgColor
        self.newView.avatar.layer.cornerRadius = self.newView.avatar.frame.height/2
        self.newView.avatar.clipsToBounds = true
        
        collectionViewSetup()

    }
    
    func collectionViewSetup() {
        self.newView.items.delegate = self
        self.newView.items.dataSource = self
        self.newView.items.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    //        collectionView.register(PhotCell.self, forCellWithReuseIdentifier: cellID)
    //        layout.itemSize = CGSize
    //        layout.minimumLineSpacing
    //        layout.sectionInset
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.newView.itemsLayout.invalidateLayout()
    }

//    @objc func tap(_ sender: UITapGestureRecognizer) {
//        let location = sender.location(in: self.newView.items)
//        let indexPath = self.newView.items.indexPathForItem(at: location)
//       if let index = indexPath {
//          print("Got clicked on index: \(index)!")
//       }
//    }

    }

    extension HomeViewController: UICollectionViewDelegate {

    }

    extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? HistoryCell else { return UICollectionViewCell() }
        let index = indexPath.item
        let history = NetworkService.history!.items[index]
        cell.setup2(history: history)
//        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NetworkService.history!.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    }

    extension HomeViewController:	UICollectionViewDelegateFlowLayout {
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


