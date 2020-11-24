//
//  EditTableViewController.swift
//  TestTask
//
//  Created by Nikita Entin on 22.11.2020.
//

import UIKit

class EditTableViewController: UITableViewController {
    
    private var numberOfCells = 3
    private var arrayOfCells = [EditTableViewCell]()
    static var editDict = [String:String]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath) as! EditTableViewCell
        arrayOfCells.append(cell)
        //значения в ячейках по умолчанию
        switch indexPath.row {
        case 0:
            cell.firstParameterField.text = "Имя"
        case 1:
            cell.firstParameterField.text = "Возраст"
        case 2:
            cell.firstParameterField.text = "Профессия"
        default:
            break
        }
        return cell
    }
    
    @IBAction func addCell(_ sender: UIBarButtonItem) {
        numberOfCells += 1
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            numberOfCells -= 1
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    //сохранение данных по нажатию кнопки
    @IBAction func saveParams(_ sender: UIButton) {
        for cell in arrayOfCells {
            EditTableViewController.editDict[cell.firstParameterField.text ?? ""] = cell.secondParameterField.text
        }
        
        let dest = storyboard!.instantiateViewController(identifier: "survey_vc") as! SurveyTableViewController
        dest.surveyDict = EditTableViewController.editDict
        let params = EditTableViewController.editDict.compactMap {"\($0)=\($1)"}.joined(separator: "\n")
        let file = "file.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            do {
                //сохраняем в песочницу
                try params.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                //сохраняем в files на iPhone
                let vc = UIActivityViewController(activityItems: [path], applicationActivities: nil)
                present(vc,animated: true)
            } catch {
                print(error)
            }
        }
    }
}
