//
//  knTabBarItem.swift
//  Verifierer
//
//  Created by Георгий Андреев on 21.10.2020.
//

import Foundation
import UIKit

class knTabBarItem: UIButton {
    var itemHeight: CGFloat = 0
    var lock = false
    var color: UIColor = UIColor.lightGray {
        didSet {
            guard lock == false else { return }
            iconImageView.image = iconImageView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconImageView.tintColor = color
            textLabel.textColor = color
        }}
    
    private let iconImageView = knUIMaker.makeImageView(contentMode: .scaleAspectFit)
    private var icon: UIImage = UIImage()
    private var iconActive: UIImage = UIImage()
    private let textLabel = knUIMaker.makeLabel(font: UIFont.systemFont(ofSize: 11),
                                        color: .black, alignment: .center)
    
    func setRect() {
            self.backgroundColor = .purple
           self.layer.cornerRadius = 0.5 * self.bounds.size.width
           self.clipsToBounds = true
        self.lock = true
        self.itemHeight = 70
    }
    
    func unSetRect() {
        self.backgroundColor = nil
        self.lock = false
        self.itemHeight = 70
    }
    
    func changeIcon(active: Bool) {
        if (active) {
            self.iconImageView.image = self.iconActive
        } else {
            self.iconImageView.image = self.icon
        }    
    }
    
    convenience init(icon: UIImage, title: String, swapIcon: UIImage,
                     font: UIFont = UIFont.systemFont(ofSize: 18)) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        self.icon = icon
        self.iconActive = swapIcon
        iconImageView.image = self.icon
        textLabel.text = title
        textLabel.font = UIFont(name: font.fontName, size: 11)
        setupView()
    }
    
    private func setupView() {
        addSubviews(views: iconImageView, textLabel)
        iconImageView.top(toView: self, space: 4)
        iconImageView.centerX(toView: self)
        iconImageView.square()
        
        let iconBottomConstant: CGFloat = textLabel.text == "" ? -2 : -24
        iconImageView.bottom(toView: self, space: iconBottomConstant)
        
        textLabel.bottom(toView: self, space: -2)
        textLabel.centerX(toView: self)
    }
}
