//
//  AddReview.swift
//  Verifierer
//
//  Created by Георгий Андреев on 24.10.2020.
//

import UIKit
import FloatRatingView

class AddReview: UIView {
    
    var delegate:AddReviewDelegate?

    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var floatRating: FloatRatingView!
    var imagePicker: ImagePicker!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    */
    @IBAction func Send(_ sender: UIButton) {
        delegate?.send()
    }    
    
    @IBAction func AddImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
}

protocol AddReviewDelegate {
    func send()
}
