//
//  SelectionViewController.swift
//  CapstoneProject
//
//  Created by yujin on 4/27/24.
//

import UIKit

class SelectionMissionViewController: UIViewController {
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var forHereButton: UIButton!
    @IBOutlet weak var takeOutButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
        
    var isFHChecked: Bool = false // foodhere 매장식사
    var isTOChecked: Bool = false // takeout 포장하기
    var totalPrice: Int?
    var systemColor = UIColor(hexCode: "143875")
    var mission: Mission?
    var action: Action?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        forHereButton.addTarget(self, action: #selector(forHereButtonClicked), for: .touchUpInside)
        takeOutButton.addTarget(self, action: #selector(takeOutButtonClicked), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
}

extension SelectionMissionViewController{ // Button EventHandlers
    @objc func forHereButtonClicked(sender: UIButton) {
        isFHChecked = !isFHChecked // Toggle forHere button state
        
        if isFHChecked {
            isTOChecked = false // Explicitly set takeOut button to off when forHere is on
            configureButton(button: sender, isActive: true)
            configureButton(button: takeOutButton, isActive: false)
        } else {
            configureButton(button: sender, isActive: false)
        }
        
        action = .forhere
    }
    
    @objc func takeOutButtonClicked(sender: UIButton) {
        print(isTOChecked)
        isTOChecked = !isTOChecked // Toggle takeOut button state
        
        if isTOChecked {
            isFHChecked = false // Explicitly set forHere button to off when takeOut is on
            configureButton(button: sender, isActive: true)
            configureButton(button: forHereButton, isActive: false)
        } else {
            configureButton(button: sender, isActive: false)
        }
        
        action = .takeout
        
    }
    
    func configureButton(button: UIButton, isActive: Bool) {
        button.setTitleColor(isActive ? .white : systemColor, for: .normal)
        button.backgroundColor = isActive ? systemColor : .white
    }
    
    @objc func confirmButtonClicked(sender: UIButton){
        forHereButton.backgroundColor = .white
        takeOutButton.backgroundColor = .white
        forHereButton.setTitleColor(systemColor, for: .normal)
        takeOutButton.setTitleColor(systemColor, for: .normal)
        
        if action == mission?.action {
            if isFHChecked == true || isTOChecked == true {
                performSegue(withIdentifier: "GotoMissionSuccessViewController", sender: self)
            }
        }
        else {
            performSegue(withIdentifier: "GotoFeedBackViewController", sender: nil)
        }
       
        
        
    }
    
    @objc func cancelButtonClicked(sender: UIButton){
        
    }
}

extension SelectionMissionViewController{ //  widgetStyle
    func setupUI() {
        selectionView.layer.cornerRadius = 10 // 뷰 코너를 둥글게
        
        forHereButton.layer.cornerRadius = 10
        forHereButton.layer.borderColor = systemColor.cgColor
        forHereButton.layer.borderWidth = 2
        forHereButton.tintColor = systemColor
        
        takeOutButton.layer.cornerRadius = 10
        takeOutButton.layer.borderColor = systemColor.cgColor
        takeOutButton.layer.borderWidth = 2
        takeOutButton.tintColor = systemColor
        
        confirmButton.layer.cornerRadius = 10
        confirmButton.layer.borderColor = systemColor.cgColor
        confirmButton.layer.borderWidth = 2
        confirmButton.tintColor = systemColor
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderColor = systemColor.cgColor
        cancelButton.layer.borderWidth = 2
        cancelButton.tintColor = systemColor
    }
}

//extension SelectionMissionViewController{
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let payViewController = segue.destination as? PayViewController
////        payViewController?.selectionMissionViewController = self
//    }
//}

