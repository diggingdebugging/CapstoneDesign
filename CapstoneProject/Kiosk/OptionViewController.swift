//
//  OptionController.swift
//  CapstoneProject
//
//  Created by 이은서 on 4/29/24.
//
import UIKit
import SwiftEntryKit

class OptionViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addbtn: UIButton!
    @IBOutlet weak var optionlmage: UIImageView!
    
    @IBOutlet var optionbtn: [UIButton]!
    @IBOutlet var hotcoldbtn: [UIButton]!
    
    var kioskViewController: KioskViewController?
    var optionindex : Int? = nil //버튼 인덱스값
    var hotcoldindex : Int? = nil
    
    // var selectedOption: String?
    var foodIndex: Int?
    var hotOrCold: HotOrCold?
    var density: Density?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let foodIndex = foodIndex{
            let option = kioskViewController?.select
            var selectedFood: Food = Coffee.list[foodIndex]
            switch option {
            case .Coffee :
                selectedFood = Coffee.list[foodIndex]
            case .AdeAndTea :
                selectedFood = AdeAndTea.list[foodIndex]
            case .Drink :
                selectedFood = Drink.list[foodIndex]
            case .Desert :
                selectedFood = Desert.list[foodIndex]
            default :
                break
            }
            nameLabel.text = selectedFood.name
            priceLabel.text = String(selectedFood.price)
            optionlmage.image = UIImage(named: selectedFood.imageName)
        }
    }
    
    @IBAction func addbtn(_ sender: UIButton) { //담기버튼
        guard optionindex != nil && hotcoldindex != nil else {
            if optionindex == nil {
                showSnackbar(message: "농도를 선택해주세요",  description: nil)
            }
            if hotcoldindex == nil {
                showSnackbar(message: "hot/cold를 선택해주세요",  description: nil)
            }
            return
        }
        if let foodIndex = foodIndex {
            let option = kioskViewController?.select
            var selectedFood: Food?
            switch option {
            case .Coffee:
                selectedFood = Coffee.list[foodIndex]
            case .AdeAndTea:
                selectedFood = AdeAndTea.list[foodIndex]
            case .Drink:
                selectedFood = Drink.list[foodIndex]
            case .Desert:
                selectedFood = Desert.list[foodIndex]
            default:
                break
            }
            if let food = selectedFood {
                var foodState = FoodState(food: food, count: 1, optionPrice: 0, totalPrice: food.price)
                foodState.hotOrCold = self.hotOrCold
                foodState.density = self.density
                if foodState.density == .addShot {
                    foodState.optionPrice = 500
                } else if foodState.density == .addShot2 {
                    foodState.optionPrice = 1000
                }
                foodState.totalPrice += foodState.optionPrice
                kioskViewController?.foodStateList.append(foodState)
                kioskViewController?.tableView.reloadData()
            }
        }
        
        
        //     let selectedHotColdIndex = hotcoldindex
        //  print("Selected Hot/Cold index: \(selectedHotColdIndex ?? -1)")
        //   let selectedOptionIndex = optionindex
        //  print("Selected option index: \(selectedOptionIndex ?? -1)")
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelbtn(_ sender: UIButton) { // 취소버튼
        dismiss(animated: true, completion: nil)
        print("취소되었습니다.")
    }
    
    @IBAction func optiontouchbtn(_ sender: UIButton) { //
        if optionindex != nil{
            if !sender.isSelected{
                for index in optionbtn.indices{
                    optionbtn[index].isSelected = false
                }
                sender.isSelected = true
                optionindex = optionbtn.firstIndex(of: sender)
                optionSelect()
                
                //버튼 선택이 완료되면 색깔 바꾸기
                
                if hotcoldindex != nil {
                    addbtn.backgroundColor = .orange
                }
                
            }else{
                sender.isSelected = false
                optionindex = nil
                optionSelect()
            }
        }else{
            sender.isSelected = true
            optionindex = optionbtn.firstIndex(of: sender)
            optionSelect()
        }
    }
    
    @IBAction func hotcoldtouchbtn(_ sender: UIButton) {
        if hotcoldindex != nil{
            if !sender.isSelected{
                for index1 in hotcoldbtn.indices{
                    hotcoldbtn[index1].isSelected = false
                }
                sender.isSelected = true
                hotcoldindex = hotcoldbtn.firstIndex(of: sender)
                hotOrColdSelect()
                //옵션선택이 완료되면 버튼 색깔 바꾸기
                
                if optionindex != nil {
                    addbtn.backgroundColor = .orange
                }
            }else{
                sender.isSelected = false
                hotcoldindex = nil
                hotOrColdSelect()
            }
        }else{
            sender.isSelected = true
            hotcoldindex = hotcoldbtn.firstIndex(of: sender)
            hotOrColdSelect()
        }
    }
    
    func hotOrColdSelect(){
        if hotcoldindex == 0 { // hotbuttonclick
            hotOrCold = .hot
        }
        else if hotcoldindex == 1{ // coldbuttonclick
            hotOrCold = .cold
        }
        else{
            hotOrCold = nil
        }
    }
    
    func optionSelect(){
        switch optionindex {
        case 0 :
            density = .basic
        case 1 :
            density = .light
        case 2 :
            density = .addShot
        case 3 :
            density = .addShot2
        default:
            density = nil
        }
    }
}

extension OptionViewController{ // snackbar code
    func showSnackbar(message: String, description: String?, duration: Double = 1.0) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: .white)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.3, anchorPosition: .top))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2, anchorPosition: .top))
        attributes.displayDuration = duration
        let defaultButtonColor =  EKColor(UIColor.systemBlue)

        let title = EKProperty.LabelContent(text: message, style: .init(font: .systemFont(ofSize: 20), color: defaultButtonColor, alignment: .center))
        let descriptionContent = EKProperty.LabelContent(text: description ?? "", style: .init(font: .systemFont(ofSize: 14), color: .white))
        
        let simpleMessage = EKSimpleMessage(title: title, description: descriptionContent)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)

        let contentView = EKNotificationMessageView(with: notificationMessage)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
