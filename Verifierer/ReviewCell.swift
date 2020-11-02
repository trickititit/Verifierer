//
//  ReviewCell.swift
//  Verifierer
//
//  Created by Георгий Андреев on 29.10.2020.
//

import UIKit
import FloatRatingView
import Alamofire

class ReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var rating: FloatRatingView!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setup3(review: Review) {

        if (review.reviewFiles.count > 0) {
            AF.download(NetworkService.BaseUrl + "image/" + review.reviewFiles[0].id).responseData { response in
//                  debugPrint(response)
                if let data = response.value {
                    self.image.image = UIImage(data: data)
                }
            }
        }
        self.text.frame.size.height = calculatedHeight(for: review.description, width: self.text.frame.size.width)
        self.avatar.layer.masksToBounds = false
        self.avatar.layer.cornerRadius = self.avatar.frame.height/2
        self.avatar.clipsToBounds = true
        
        AF.download(NetworkService.BaseUrl + "users/" + review.user.id + "/avatar").responseData { response in
             // debugPrint(response)
            if let data = response.value {
                self.avatar.image = UIImage(data: data)
            }
        }
        
        let dateFormatter = DateFormatter()
        
        self.text.text = review.description
        self.userName.text = review.user.name
        self.rating.rating = Double(review.stars)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        //print(review.creationDate)
        let date = dateFormatter.date(from: review.creationDate)
        let formatter3 = DateFormatter()
        formatter3.locale = Locale(identifier: "ru_RU")
        formatter3.dateFormat = "HH:mm E, d MMM y"
        self.date.text = formatter3.string(from: date!)

}
    
    func calculatedHeight(for text: String, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width,
                                          height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
}
