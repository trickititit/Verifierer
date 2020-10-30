//
//  SellerCell.swift
//  Verifierer
//
//  Created by Георгий Андреев on 10.10.2020.
//

import UIKit

class SellerCell: UICollectionViewCell {
    
    var id = 0

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup2(bonus: Bonus) {
                
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width / 2, height: 25))
        label2.center = CGPoint(x: self.frame.size.width, y: 50)
        label2.font = UIFont(name: "Noto Sans Myanmar Bold", size: 20)
        label2.textAlignment = .left
        label2.textColor = UIColor.white
        label2.text = "\(bonus.value)"
        self.addSubview(label2)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width / 2, height: 25))
        label.center = CGPoint(x: 100, y: 50)
        label.font = UIFont(name: "Noto Sans Myanmar Bold", size: 20)
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.text = bonus.bonusShop.name
        self.addSubview(label)
        backgroundColor = UIColor(hex: bonus.bonusShop.color)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.clear.cgColor
        self.id = bonus.bonusShop.id
//        self.layer.masksToBounds = true

//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowOffset = .zero
//        self.layer.shadowRadius = 5
//        self.layer.shadowOpacity = 1
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    
//        vw.layer.shadowPath = UIBezierPath(rect: vw.bounds).cgPath
//        vw.layer.shadowRadius = 5
//        vw.layer.shadowOffset = .zero
//        vw.layer.shadowOpacity = 1


}

}
