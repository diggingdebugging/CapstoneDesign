//
//  MissionSuccessViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/28/24.
//
import UIKit
import Lottie

class MissionSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        let animationView = LottieAnimationView(name: "celebration") // 다운로드한 파일 이름
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        view.addSubview(animationView)
        animationView.play()
    }
}
