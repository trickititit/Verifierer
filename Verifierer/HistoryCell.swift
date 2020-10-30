//
//  HistoryCell.swift
//  Verifierer
//
//  Created by Георгий Андреев on 27.10.2020.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    @IBOutlet weak var Bonus: UILabel!
    
    @IBOutlet weak var Date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup2(history: History) {
        let dateFormatter = DateFormatter()
        
        self.Bonus.text = history.shopName + " полученно " + String(history.addedValue) + " бонусов."
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
//        print(history.scannedAt)
        let date = dateFormatter.date(from: history.scannedAt)
        let formatter3 = DateFormatter()
        formatter3.locale = Locale(identifier: "ru_RU")
        formatter3.dateFormat = "HH:mm E, d MMM y"
        self.Date.text = formatter3.string(from: date!)

}
    
    
}
