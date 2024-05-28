//
//  MissionSuccessViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/28/24.
//
import UIKit
import Lottie

class MissionSuccessViewController: UIViewController {
    let celebrationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        let animationView = LottieAnimationView(name: "celebration") // 다운로드한 파일 이름
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        
        celebrationLabel.text = "미션 성공!"
        celebrationLabel.font = UIFont(name: "Jalnan2", size: 28)
        celebrationLabel.textAlignment = .center
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        celebrationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        view.addSubview(celebrationLabel)
        
        animationView.play()
        NSLayoutConstraint.activate([
                   animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   animationView.topAnchor.constraint(equalTo: view.topAnchor),
                   animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
        
        NSLayoutConstraint.activate([
            celebrationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            celebrationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            celebrationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            celebrationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])        
    }
}
