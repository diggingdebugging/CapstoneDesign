//
//  MainViewController.swift
//  CapstoneProject
//
//  Created by 조윤호 on 4/18/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //클릭시 Kiosk로 이동
    @IBAction func kioskButtonTapped(_ sender: UIButton) {
//        print("kioskButtonTapped")
        let storyboard = UIStoryboard(name: "Kiosk", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "KioskViewController") as! KioskViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func gptButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Mission", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DifficultySelectViewController") as! DifficultySelectViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

