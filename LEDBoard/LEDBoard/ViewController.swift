//
//  ViewController.swift
//  LEDBoard
//
//  Created by 권찬호 on 2022/02/16.
//

import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {

    @IBOutlet weak var contentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentsLabel.textColor = .yellow
    }
    
    // 데이터 주고 받기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController =  segue.destination as? SettingViewController{
            settingViewController.delegate = self
            settingViewController.ledText = self.contentsLabel.text
            settingViewController.textColor = self.contentsLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
    }
    
    // LEDBoardSettingDelegate 필수 func
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            self.contentsLabel.text = text
        }
        self.contentsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
    
}

