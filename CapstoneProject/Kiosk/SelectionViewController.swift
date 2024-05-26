//
//  SelectionViewController.swift
//  CapstoneProject
//
//  Created by yujin on 4/27/24.
//

import UIKit

class SelectionViewController: UIViewController {
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var forHereButton: UIButton!
    @IBOutlet weak var takeOutButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var isFHChecked: Bool = false // foodhere 매장식사
    var isTOChecked: Bool = false // takeout 포장하기
    var totalPrice: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWidget()
        
        forHereButton.addTarget(self, action: #selector(forHereButtonClicked), for: .touchUpInside)
        takeOutButton.addTarget(self, action: #selector(takeOutButtonClicked), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
}

extension SelectionViewController{ // Button EventHandlers
    @objc func forHereButtonClicked(sender: UIButton) {
        isFHChecked = !isFHChecked // Toggle forHere button state
        
        if isFHChecked {
            isTOChecked = false // Explicitly set takeOut button to off when forHere is on
            configureButton(button: sender, isActive: true)
            configureButton(button: takeOutButton, isActive: false)
        } else {
            configureButton(button: sender, isActive: false)
        }
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
    }
    
    func configureButton(button: UIButton, isActive: Bool) {
        button.setTitleColor(isActive ? .white : .systemOrange, for: .normal)
        button.backgroundColor = isActive ? .systemOrange : .white
    }
    
    @objc func confirmButtonClicked(sender: UIButton){
        forHereButton.backgroundColor = .white
        takeOutButton.backgroundColor = .white
        forHereButton.setTitleColor(.systemOrange, for: .normal)
        takeOutButton.setTitleColor(.systemOrange, for: .normal)
        
        
        if isFHChecked == true || isTOChecked == true {
            performSegue(withIdentifier: "GoToPayViewController", sender: self)
        }
        
        
    }
    
    @objc func cancelButtonClicked(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectionViewController{ //  widgetStyle
    func setWidget() {
        selectionView.layer.cornerRadius = 10 // 뷰 코너를 둥글게
        
        forHereButton.layer.cornerRadius = 10
        forHereButton.layer.borderColor = UIColor.systemOrange.cgColor
        forHereButton.layer.borderWidth = 2
        
        takeOutButton.layer.cornerRadius = 10
        takeOutButton.layer.borderColor = UIColor.systemOrange.cgColor
        takeOutButton.layer.borderWidth = 2
        
        confirmButton.layer.cornerRadius = 10
        confirmButton.layer.borderColor = UIColor.systemOrange.cgColor
        confirmButton.layer.borderWidth = 2
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderColor = UIColor.systemOrange.cgColor
        cancelButton.layer.borderWidth = 2
    }
}

extension SelectionViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let payViewController = segue.destination as? PayViewController
        payViewController?.selectionViewController = self  
    }
}
