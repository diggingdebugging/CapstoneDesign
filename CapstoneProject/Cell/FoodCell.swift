//
//  FoodCell.swift
//  CapstoneProject
//
//  Created by 조윤호 on 4/18/24.
//

import UIKit

class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //FoodData를 받아서 셀을 업데이트해줄 수 있는 메소드
    func configure(_ food: Food){
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false

        thumbnailImageView.image = UIImage(named: food.imageName)
        nameLabel.text = food.name
        priceLabel.text = String(food.price)
    }
}
