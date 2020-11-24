//
//  ViewController.swift
//  TestTask
//
//  Created by Nikita Entin on 20.11.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let users = [(login:"123", password:"123")]
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var loginTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var checkLabel: UILabel!
    
    //кнопка проверки логина/пароля
    @IBAction func checkButton(_ sender: UIButton) {
        for i in users.indices {
            if loginTxt.text == users[i].login && passwordTxt.text == users[i].password {
                checkLabel.text = "Correct"
                progressView.progress = 1
                let vc = storyboard?.instantiateViewController(identifier: "navigator_vc") as! UINavigationController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            } else {
                checkLabel.text = "Wrong,try again"
                loginTxt.text = ""
                passwordTxt.text = ""
                progressView.progress = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLabel.text = ""
        progressView.progress = 0
    }
}

