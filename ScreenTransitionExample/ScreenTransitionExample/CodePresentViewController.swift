//
//  CodePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 권찬호 on 2022/02/15.
//

import UIKit

protocol SendDataDelegate: AnyObject{
    func sendData(name: String)
}
class CodePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    weak var delegate: SendDataDelegate? // weak를 붙여야 데이터 누수를 막음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "Kwon")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
