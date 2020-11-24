//
//  EditTableViewCell.swift
//  TestTask
//
//  Created by Nikita Entin on 22.11.2020.
//

import UIKit

class EditTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    //по нажатию на поле ввода текста появится возможность изменять его в разделе Редактирование
    @IBOutlet weak var firstParameterField: UITextField!{
        didSet {
            firstParameterField.delegate = self
            let tap = UITapGestureRecognizer(target: self, action: #selector(activate))
            tap.numberOfTapsRequired = 2
            addGestureRecognizer(tap)
        }
    }
    
    @IBOutlet weak var secondParameterField: UITextField!
    
    @objc private func activate() {
        firstParameterField.isEnabled = true
        firstParameterField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstParameterField.isEnabled = false
        firstParameterField.resignFirstResponder()
        return true
    }
    
}
