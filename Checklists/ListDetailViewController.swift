//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Mario Alberto Gonzalez on 31/01/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import UIKit

protocol AllListsViewControllerDelegate: class {
    func allListsViewControllerDelegateDidCancel(_ controller : ListDetailViewController)
    func allListsViewControllerDelegate(_ controller : ListDetailViewController, didFinishAdding item: Checklist)
    func allListsViewControllerDelegate(_ controller : ListDetailViewController, didFinishEditing item: Checklist)
}
class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField : UITextField!
    @IBOutlet weak var doneBarButton : UIBarButtonItem!
    
    var checklistToEdit : Checklist?
    var delegate : AllListsViewControllerDelegate?
    
    override func viewDidLoad() {
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.text
            doneBarButton.isEnabled = true
        }
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.allListsViewControllerDelegateDidCancel(self)
    }
    
    @IBAction func done() {
        if let checklist = checklistToEdit {
            checklist.text = textField.text!
            delegate?.allListsViewControllerDelegate(self, didFinishEditing: checklist)
        } else {
            let checklist = Checklist(name: textField.text!)
            delegate?.allListsViewControllerDelegate(self, didFinishAdding: checklist)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = newText.length > 0
        return true
    }
}
