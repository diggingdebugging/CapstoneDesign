//
//  FeedBackViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/23/24.
//

import UIKit

class FeedBackViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 다시하기 버튼
    @IBAction func retryBtn(_ sender: UIButton) {
       dismiss(animated: true)
    }
    
}
