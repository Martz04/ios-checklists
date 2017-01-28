//
//  ViewController.swift
//  Checklists
//
//  Created by Mario Alberto Gonzalez on 26/01/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    var rowItem: ChecklistItem
    var items: [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        rowItem = ChecklistItem()
        rowItem.text = "Walk the dog"
        rowItem.checked = false
        items.append(rowItem)
        rowItem = ChecklistItem()
        rowItem.text = "Brush my teeth"
        rowItem.checked = true
        items.append(rowItem)
        rowItem = ChecklistItem()
        rowItem.text = "Learn iOS development"
        rowItem.checked = true
        items.append(rowItem)
        rowItem = ChecklistItem()
        rowItem.text = "Soccer practice"
        rowItem.checked = false
        items.append(rowItem)
        rowItem = ChecklistItem()
        rowItem.text = "Eat ice cream"
        rowItem.checked = true
        items.append(rowItem)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckMark(for: cell, with: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            let item = items[indexPath.row]
            item.toggleCheck()
            configureCheckMark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureCheckMark(for cell:UITableViewCell, with item:ChecklistItem) -> Void {
        if(item.checked) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) -> Void {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let newIndex = items.count
        let checklist = ChecklistItem()
        checklist.text = "New Item added"
        checklist.checked = true
        items.append(checklist)
        let indexPath = IndexPath(row: newIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
}

