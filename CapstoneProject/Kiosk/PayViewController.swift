//
//  PayViewController.swift
//  CapstoneProject
//
//  Created by yujin on 4/29/24.
//

import UIKit

class PayViewController: UIViewController {
    
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var totalPriceView: UILabel!
    
    var selectionViewController: SelectionViewController!
    var systemColor = UIColor(hexCode: "143875")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWidget()
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
        
        // 화면내리기 막기
        isModalInPresentation = true
    }
    
}

extension PayViewController{
    @objc func cancelButtonClicked(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        selectionViewController.isTOChecked = false //
        selectionViewController.isFHChecked = false
    }
    
    @objc func requestButtonClicked(sender: UIButton){
        //뷰가 3초동안 나타났다가 사라지고 새로운 뷰로 전환
        let dialog = UILabel()
        dialog.text = "결제중입니다. 잠시만 가다려주세요."
        dialog.backgroundColor = .white
        dialog.textAlignment = .center
        dialog.clipsToBounds = true
        dialog.layer.cornerRadius = 10
        
        view.addSubview(dialog)
        dialog.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dialog.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            dialog.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            dialog.topAnchor.constraint(equalTo:payView.bottomAnchor , constant: 60),
            dialog.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
        
        Timer.scheduledTimer(
            timeInterval: 3,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: false
        )
        sender.isEnabled = false
    }
    
    @objc func timerAction(){
        performSegue(withIdentifier: "GotoPayImage", sender: nil)
        // 콘텐츠 초기화 예시
        self.view.subviews.forEach({ $0.removeFromSuperview() })
    }
}
    
    


extension PayViewController{ // widgetStyle
    func setWidget() {
        payView.layer.cornerRadius = 10
        
        totalView.layer.cornerRadius = 10
        totalView.layer.borderWidth = 2
        totalView.layer.borderColor = systemColor.cgColor
        
        monthView.layer.cornerRadius = 10
        monthView.layer.borderWidth = 2
        monthView.layer.borderColor = systemColor.cgColor
        
        numberView.layer.cornerRadius = 10
        numberView.layer.borderWidth = 2
        numberView.layer.borderColor = systemColor.cgColor
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = systemColor.cgColor
        cancelButton.setTitleColor(systemColor, for: .normal)
        
        requestButton.layer.cornerRadius = 10
        requestButton.layer.borderWidth = 2
        requestButton.layer.borderColor = systemColor.cgColor
        requestButton.setTitleColor(systemColor, for: .normal)
        
        totalPriceView.text = String(selectionViewController.totalPrice!)
    }
}

extension PayViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.source)
    }
}
