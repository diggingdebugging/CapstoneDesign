//
//  FeedBackViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/23/24.
//

import UIKit
import Lottie

class FeedBackViewController: UIViewController {
    let retryLabel = UILabel()
    let retryButton = UIButton()
    let animationView = LottieAnimationView(name: "retry2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // 터치이벤트
        retryButton.addTarget(self, action: #selector(retryButtonTouched), for: .touchUpInside)
    }
    
    func setupUI(){
        // retryLabel
        retryLabel.text = "다시 시도해보세요"
        retryLabel.font = UIFont(name: "Jalnan2", size: 28)
        retryLabel.textAlignment = .center
        
        
        // animationView
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        
        // retryButton
        retryButton.setTitle("돌아가기", for: .normal)
        retryButton.backgroundColor = UIColor(hexCode: "143785")
        retryButton.tintColor = UIColor.white
        retryButton.titleLabel?.font = UIFont(name: "Jalnan2", size: 25)
        retryButton.layer.cornerRadius = 10
        
        
        retryLabel.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(retryLabel)
        view.addSubview(animationView)
        view.addSubview(retryButton)
        
        // 애니메이션 실행
        animationView.play()
        
        // constraint
        NSLayoutConstraint.activate([
                  // Animation View Constraints
                  animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                  animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                  animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                  animationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                  
                  // Retry Label Constraints
                  retryLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
                  retryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                  retryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                  
                  //Retry Button Constraints
                  retryButton.topAnchor.constraint(equalTo: retryLabel.bottomAnchor, constant: 20),
                  retryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
                  retryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
              ])
    }
    
    @objc func retryButtonTouched(sender: UIButton){
        dismiss(animated: true)
    }
}
