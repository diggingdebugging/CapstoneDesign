//
//  OptionCell.swift
//  CapstoneProject
//
//  Created by 조윤호 on 5/11/24.
//

import UIKit

protocol OptionCellDelegate: AnyObject {
    func didTapRemoveButton(on cell: OptionCell)
    func didUpdateCountAndPrice(on cell: OptionCell, count: Int, price: Int)
    
}

class OptionCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var optionOneLabel: UILabel!
    @IBOutlet weak var optionOnePriceLabel: UILabel!
    @IBOutlet weak var optionTwoLabel: UILabel!
    @IBOutlet weak var optionTwoPriceLabel: UILabel!
    
    weak var delegate: OptionCellDelegate?
    
    var count: Int! // 상품 개수
    var totalPrice: Int! // cell안에서 누적된 상품 가격
    var price: Int! // 상품 가격
    var optionPrice: Int = 0
    
    @IBAction func XmarkButtonTapped(_ sender: UIButton) { // 'x'버튼을 누른 상황
        delegate?.didTapRemoveButton(on: self)
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) { // '-'버튼을 누른 상황
        count -= 1
        if count == 0 { // count가 1일때 '-'버튼을 누른상황
            delegate?.didTapRemoveButton(on: self)
        } else {
            countLabel.text = String(count)
            totalPrice -= price
            priceLabel.text = String(totalPrice)
            delegate?.didUpdateCountAndPrice(on: self, count: count, price: price)
        }
        
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) { // '+'버튼을 누른 상황
        count += 1
        countLabel.text = String(count)
        totalPrice! += price
        totalPrice! += optionPrice
        priceLabel.text = String(totalPrice)
        delegate?.didUpdateCountAndPrice(on: self, count: count, price: price)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
