//
//  OptionMissionViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/23/24.
//

import UIKit
import SwiftEntryKit

class OptionMissionViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var optionImage: UIImageView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet var hotOrColdBtn: [UIButton]!
    @IBOutlet var optionBtn: [UIButton]!
    
    var kioskMissionViewController: KioskMissionViewController?
    var optionindex : Int? = nil //버튼 인덱스값
    var hotcoldindex : Int? = nil
    
    
    // var selectedOption: String?
    var foodIndex: Int?
    var hotOrCold: HotOrCold?
    var density: Density?
    var missionRef: Mission?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        missionRef = kioskMissionViewController?.mission
        setupUI()
        
        // 화면내리기 막기
        isModalInPresentation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let foodIndex = foodIndex{
            let option = kioskMissionViewController?.select
            var selectedFood: Food = Coffee.list[foodIndex]
            switch option {
            case .Coffee :
                selectedFood = Coffee.list[foodIndex]
            case .AdeAndTea :
                selectedFood = AdeAndTea.list[foodIndex]
                buttonSetting()
            case .Drink :
                selectedFood = Drink.list[foodIndex]
                buttonSetting()
            case .Desert :
                selectedFood = Desert.list[foodIndex]
                buttonSetting()
            default :
                break
            }
            nameLabel.text = selectedFood.name
            priceLabel.text = String(selectedFood.price)
            optionImage.image = UIImage(named: selectedFood.imageName)
        }
    }
    
    func buttonSetting(){ // cold, basic
        hotOrColdBtn[1].isSelected = true
        optionBtn[0].isSelected = true
        hotOrColdBtn[0].isEnabled = false
        optionBtn[1].isEnabled = false
        optionBtn[2].isEnabled = false
        optionBtn[3].isEnabled = false
    }
    
    func setupUI(){
        nameLabel.layer.masksToBounds = true  // 추가
        priceLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 10
        priceLabel.layer.cornerRadius = 10
        optionImage.layer.cornerRadius = 10
               
        hotOrColdBtn[0].layer.cornerRadius = 10
        hotOrColdBtn[1].layer.cornerRadius = 10
        for i in 0...3 {
            optionBtn[i].layer.cornerRadius = 10
        }
        
        cancelBtn.layer.cornerRadius = 10
        addBtn.layer.cornerRadius = 10
        
        
        
    }
    
   
    
    @IBAction func addBtnTouched(_ sender: UIButton) { //담기버튼
        if let foodIndex = foodIndex {
            let option = kioskMissionViewController?.select
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
                if selectedFood as? Coffee != nil {
                    guard optionindex != nil && hotcoldindex != nil else {
                        if optionindex == nil {
                            showSnackbar(message: "농도를 선택해주세요",  description: nil)
                        }
                        if hotcoldindex == nil {
                            showSnackbar(message: "hot/cold를 선택해주세요",  description: nil)
                        }
                        return
                    }
                    foodState.hotOrCold = self.hotOrCold
                    foodState.density = self.density
                    if foodState.density == .addShot {
                        foodState.optionPrice = 500
                    } else if foodState.density == .addShot2 {
                        foodState.optionPrice = 1000
                    }
                    foodState.totalPrice += foodState.optionPrice
                }
                else {
                    foodState.hotOrCold = nil
                    foodState.density = nil
                }
                
                kioskMissionViewController?.foodStateList.append(foodState)
                kioskMissionViewController?.tableView.reloadData()
            }
        }
        
        
        //     let selectedHotColdIndex = hotcoldindex
        //  print("Selected Hot/Cold index: \(selectedHotColdIndex ?? -1)")
        //   let selectedOptionIndex = optionindex
        //  print("Selected option index: \(selectedOptionIndex ?? -1)")
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnTouched(_ sender: UIButton) { // 취소버튼
        dismiss(animated: true, completion: nil)
        print("취소되었습니다.")
    }
    
    @IBAction func optiontouchbtn(_ sender: UIButton) { //
        if optionindex != nil{
            if !sender.isSelected{
                for index in optionBtn.indices{
                    optionBtn[index].isSelected = false
                }
                sender.isSelected = true
                optionindex = optionBtn.firstIndex(of: sender)
                optionSelect()
                
            }else{
                sender.isSelected = false
                optionindex = nil
                optionSelect()
            }
        }else{
            sender.isSelected = true
            optionindex = optionBtn.firstIndex(of: sender)
            optionSelect()
        }
    }
    
    @IBAction func hotOrColdTouchBtn(_ sender: UIButton) {
        if hotcoldindex != nil{
            if !sender.isSelected{
                for index1 in hotOrColdBtn.indices{
                    hotOrColdBtn[index1].isSelected = false
                }
                sender.isSelected = true
                hotcoldindex = hotOrColdBtn.firstIndex(of: sender)
                hotOrColdSelect()
                //옵션선택이 완료되면 버튼 색깔 바꾸기
                
                if optionindex != nil {
                    addBtn.backgroundColor = .orange
                }
            }else{
                sender.isSelected = false
                hotcoldindex = nil
                hotOrColdSelect()
            }
        }else{
            sender.isSelected = true
            hotcoldindex = hotOrColdBtn.firstIndex(of: sender)
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
        if kioskMissionViewController?.mission?.difficulty == .basic {
            if kioskMissionViewController?.mission?.answers[0].selectHotOrDrink != hotOrCold {
                performSegue(withIdentifier: "GotoFeedBackViewController2" , sender: nil)
            }
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
        
        if kioskMissionViewController?.mission?.difficulty == .basic {
            if kioskMissionViewController?.mission?.answers[0].selectDensity != density {
                performSegue(withIdentifier: "GotoFeedBackViewController2" , sender: nil)
            }
        }
    }
}

extension OptionMissionViewController{ // snackbar code
    func showSnackbar(message: String, description: String?, duration: Double = 1.0) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: .white)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.3, anchorPosition: .top))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2, anchorPosition: .top))
        attributes.displayDuration = duration
        let defaultButtonColor =  EKColor(UIColor(hexCode: "FF7F00"))

        let title = EKProperty.LabelContent(text: message, style: .init(font: .boldSystemFont(ofSize: 18), color: defaultButtonColor, alignment: .center))
        let descriptionContent = EKProperty.LabelContent(text: description ?? "", style: .init(font: .boldSystemFont(ofSize: 14), color: .white))
        
        let simpleMessage = EKSimpleMessage(title: title, description: descriptionContent)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)

        let contentView = EKNotificationMessageView(with: notificationMessage)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
