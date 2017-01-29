//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Mario Alberto Gonzalez on 27/01/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textInput.becomeFirstResponder()
        if let item = itemToEdit {
            title = "Edit Item"
            textInput.text = item.text
            saveButton.isEnabled = true
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    @IBAction func save() {
        if let item = itemToEdit {
            item.text = textInput.text!
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        }else {
            let checklist = ChecklistItem()
            checklist.text = textInput.text!
            checklist.checked = false
            
            delegate?.itemDetailViewController(self, didFinishAdding: checklist)
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        saveButton.isEnabled = (newText.length > 0)
        return true
    }
}
