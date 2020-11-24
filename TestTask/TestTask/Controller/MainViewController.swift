//
//  MainViewController.swift
//  TestTask
//
//  Created by Nikita Entin on 20.11.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    private var menuShown = false
    // по наатию на кнопку меню появляется sideBar слева
    @IBAction func tappedButton(_ sender: UIBarButtonItem) {
        if menuShown == false {
            leading.constant = UIScreen.main.bounds.width * 2 / 5
            trailing.constant = -UIScreen.main.bounds.width * 2 / 5
            menuShown = true
        } else {
            leading.constant = 0
            trailing.constant = 0
            menuShown = false
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.manualSwipe))
        leftSwipe.direction = .left
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.manualSwipe))
        rightSwipe.direction = .right
        
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    ///добавление жестов
    @objc func manualSwipe(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case .right:
            leading.constant = UIScreen.main.bounds.width * 2 / 5
            trailing.constant = -UIScreen.main.bounds.width * 2 / 5
        case .left:
            leading.constant = 0
            trailing.constant = 0
        default:
            break
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        leading.constant = 0
        trailing.constant = 0
        menuShown = false
    }
}
