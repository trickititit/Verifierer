//
//  ProductViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 14.10.2020.
//

import UIKit
import Alamofire

class ProductViewController: UIViewController {
    
    var newView = Product()
    var reviews: [Review]?
    
    var tableView: UITableView!
    
    let cellID = "ReviewCell"
    let insents = UIEdgeInsets(top: 10, left: 0, bottom: 25, right: 0)
    
    // These strings will be the data for the table view cells
       let colums: [String] = ["ID", "Название", "Цена", "Производитель", "Категория", "Страна"]

       // These are the colors of the square views in our table view cells.
       // In a real project you might use UIImages.
    var product: [String] = [NetworkService.product!.id, NetworkService.product!.name, String(NetworkService.product!.price), NetworkService.product!.manufacturer, NetworkService.product!.category, NetworkService.product!.country]

       // Don't forget to enter this in IB also
       let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.reviews = NetworkService.product_reviews!
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        var scrollView: UIScrollView!

        
        // add labelOne to the scroll view
        
        let allViewsInXibArray = Bundle.main.loadNibNamed("Product", owner: self, options: nil)

        //If you only have one view in the xib and you set it's class to MyView class
        self.newView = allViewsInXibArray?.first as! Product

        //Set wanted position and size (frame)
        self.newView.frame = self.view.bounds
        
        self.newView.productInfoTable.delegate = self
        self.newView.productInfoTable.dataSource = self
        self.newView.desc.text = NetworkService.product!.description
        self.newView.image.image = NetworkService.product_image


        //Add the view
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: self.newView.rootView.frame.size.height - 100)
        view.addSubview(scrollView)
        scrollView.addSubview(self.newView)
        self.newView.delegate = self
        collectionViewSetup()
    }
    
    func collectionViewSetup() {
        self.newView.reviews.delegate = self
        self.newView.reviews.dataSource = self
        self.newView.reviews.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    //        collectionView.register(PhotCell.self, forCellWithReuseIdentifier: cellID)
    //        layout.itemSize = CGSize
    //        layout.minimumLineSpacing
    //        layout.sectionInset
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.newView.reviewsLayout.invalidateLayout()
    }


}


extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allViewsInXibArray = Bundle.main.loadNibNamed("ProductCell", owner: self, options: nil)

        //If you only have one view in the xib and you set it's class to MyView class
        let cell:ProductCell = allViewsInXibArray?.first as! ProductCell
        

        cell.label1.text = self.colums[indexPath.row]
        cell.label2.text = self.product[indexPath.row]

        return cell
    }
    
    
    
}

extension ProductViewController: UICollectionViewDataSource {
    
    
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        as? ReviewCell else { return UICollectionViewCell() }
    let index = indexPath.item
//    print("index = " + String(index))
    let review = self.reviews![index]
    cell.setup3(review: review)
    return cell
}
    

func collectionView(_ collectionView: UICollectionView,	 numberOfItemsInSection section: Int) -> Int {
    return self.reviews!.count
}

func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // 10 - инсет, 5 - это то число, которое будет умножаться на 2 (между двумя столбцами)
    let width: CGFloat = collectionView.frame.width - 20
    let height: CGFloat = 262
    return CGSize(width: width, height: height)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return insents
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
}
    		
}

extension ProductViewController: ProductDelegate {
    
    func send() {
        let review = ReviewForm(productId: NetworkService.product!.id, bonusShopId: NetworkService.shopID, review: "", stars: 0, photo: "")
        
        AF.request(NetworkService.BaseUrl + "rewiews/add",
                   method: .post,
                   parameters: review,
                   encoder: JSONParameterEncoder.default).validate().response { response in
                    debugPrint(response)
                    if(response.response?.statusCode == 200) {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let sceneDelegate = windowScene.delegate as? SceneDelegate
                          else {
                            return
                          }
                        sceneDelegate.rootViewController.showSplashScreen()
                    } else {
                        
                    }
        }
    }
    
}

