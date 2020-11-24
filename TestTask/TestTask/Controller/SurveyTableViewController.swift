//
//  SurveyTableViewController.swift
//  TestTask
//
//  Created by Nikita Entin on 23.11.2020.
//

import UIKit

class SurveyTableViewController: UITableViewController {
    
    var surveyDict = EditTableViewController.editDict
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "edit_vc") as! EditTableViewController
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyDict.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell", for: indexPath) as! SurveyTableViewCell
        switch indexPath.row {
        case let x:
            //массив ключей
            let keys = Array(surveyDict.keys)
            let key = keys[x]
            cell.surveyParameterTitle.text = key
            cell.surveyParameterLabel.text = surveyDict[key]
        }
        return cell
    }
}
