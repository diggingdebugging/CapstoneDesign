//
//  PayImageViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/9/24.
//

import UIKit

class PayImageViewController: UIViewController {

    @IBOutlet weak var payResultView: UIView!
    @IBOutlet weak var payImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUILabel()
        payResultView.layer.cornerRadius = 10
                
        Timer.scheduledTimer(
        timeInterval: 1,
        target: self,
        selector: #selector(timerAction),
        userInfo: nil,
        repeats: true
        )
    }
    
    func addUILabel(){
        let dialog = UILabel()
        dialog.text = "결제가 완료되었습니다."
        dialog.backgroundColor = .white
        dialog.textAlignment = .center
        dialog.clipsToBounds = true
        dialog.layer.cornerRadius = 10
        
        view.addSubview(dialog)
        dialog.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dialog.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            dialog.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            dialog.topAnchor.constraint(equalTo:payResultView.bottomAnchor , constant: 100),
            dialog.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
        ])

    }
    
    @objc func timerAction(){
        let number = (Int(numberLabel.text!) ?? 5) - 1 // nameLabel.text를 정수값으로 변환후 감소
        
        numberLabel.text = String(number) // 감소된 정수값을 nameLabel에 적용
        
        if number == 0 { // 0초가 되면 타이머를 중지시키고 다시복귀
            timer?.invalidate()
            
            // 네비게이션 스택 초기화 후 새로운 뷰 컨트롤러로 이동
            if let navigationController = self.navigationController {
                // 새로운 KioskViewController 인스턴스 생성
                let storyboard = UIStoryboard(name: "Kiosk", bundle: nil)
                let kioskViewController = storyboard.instantiateViewController(withIdentifier: "KioskViewController") as! KioskViewController
                
                // 네비게이션 스택을 초기화하고 새로운 뷰 컨트롤러 설정, 이 메서드를 호출하면 네비게이션 스택에 있는 기존의 모든 뷰 컨트롤러가 제거되고, kioskViewController만 네비게이션 스택에 남음
                navigationController.setViewControllers([kioskViewController], animated: true)
            } else {
                // 네비게이션 컨트롤러가 없으면 모달로 표시
                let storyboard = UIStoryboard(name: "Kiosk", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "KioskViewController") as! KioskViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            }
        }
        
        
    }
}
