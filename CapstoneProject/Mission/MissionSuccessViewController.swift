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
    let goHomeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        goHomeButton.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        
        // 화면내리기 막기
        isModalInPresentation = true
    }

    func setupUI() {
        let animationView = LottieAnimationView(name: "celebration") // 다운로드한 파일 이름
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        
        celebrationLabel.text = "미션 성공!"
        celebrationLabel.font = UIFont(name: "Jalnan2", size: 28)
        celebrationLabel.textAlignment = .center
        
        goHomeButton.setTitle("처음으로", for: .normal)
        goHomeButton.backgroundColor = UIColor(hexCode: "143785")
        goHomeButton.tintColor = UIColor.white
        goHomeButton.titleLabel?.font = UIFont(name: "Jalnan2", size: 25)
        goHomeButton.layer.cornerRadius = 10
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        celebrationLabel.translatesAutoresizingMaskIntoConstraints = false
        goHomeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        view.addSubview(celebrationLabel)
        view.addSubview(goHomeButton)
        
        animationView.play()
        NSLayoutConstraint.activate([
                   animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   animationView.topAnchor.constraint(equalTo: view.topAnchor),
                   animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
        
        NSLayoutConstraint.activate([
            celebrationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            celebrationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            celebrationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            goHomeButton.topAnchor.constraint(equalTo: celebrationLabel.bottomAnchor, constant: 20),
            goHomeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            goHomeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            goHomeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    @objc func buttonTouched(sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
