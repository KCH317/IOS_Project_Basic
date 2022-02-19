//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by 권찬호 on 2022/02/18.
//

import UIKit

protocol LEDBoardSettingDelegate: AnyObject{
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    weak var delegate: LEDBoardSettingDelegate?
    var ledText: String?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor = .black
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    private func configureView() {
        if let ledText = self.ledText {
            self.textField.text = ledText
        }
        self.changeTextColorButton(color: self.textColor)
        self.changeBackgroundColorButton(color: self.backgroundColor)
    }
 
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender == yellowButton {
            self.changeTextColorButton(color: .yellow)
            self.textColor = .yellow
        } else if sender == purpleButton {
            self.changeTextColorButton(color: .purple)
            self.textColor = .purple
        } else {
            self.changeTextColorButton(color: .green)
            self.textColor = .green
        }
    }
    
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        if sender == blackButton {
            self.changeBackgroundColorButton(color: .black)
            self.backgroundColor = .black
        } else if sender == blueButton {
            self.changeBackgroundColorButton(color: .blue)
            self.backgroundColor = .blue
        } else {
            self.changeBackgroundColorButton(color: .orange)
            self.backgroundColor = .orange
        }
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        self.delegate?.changedSetting(
            text: self.textField.text,
            textColor: self.textColor,
            backgroundColor: self.backgroundColor
        )
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /**
     텍스트 색상 변경
     - 선택 : alpha 1
     - 비선택 : alpha 0.2
     */
    private func changeTextColorButton(color: UIColor) {
        self.yellowButton.alpha = color == UIColor.yellow ? 1 : 0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1 : 0.2
        self.greenButton.alpha = color == UIColor.green ? 1 : 0.2
    }
    
    /**
     배경 색상 변경
     - 선택 : alpha 1
     - 비선택 : alpha 0.2
     */
    private func changeBackgroundColorButton(color: UIColor) {
        self.blackButton.alpha = color == UIColor.black ? 1 : 0.2
        self.blueButton.alpha = color == UIColor.blue ? 1 : 0.2
        self.orangeButton.alpha = color == UIColor.orange ? 1 : 0.2
    }
    
}
