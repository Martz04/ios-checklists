//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Mario Alberto Gonzalez on 30/01/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController,
    AllListsViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedIndex
        if index != -1 && index < dataModel!.lists.count{
            let checklits = dataModel!.lists[index]
            performSegue(withIdentifier: "ShowChecklists", sender: checklits)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel!.lists.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        let checklist = dataModel!.lists[indexPath.row]
        cell.textLabel!.text = checklist.text
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
 
    func makeCell(for tableView:UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = dataModel!.lists[indexPath.row]
        dataModel.indexOfSelectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowChecklists", sender: checklist)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklists" {
            let controller = segue.destination as! ChecklistViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigation = segue.destination as! UINavigationController
            let controller = navigation.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }
    
    func allListsViewControllerDelegateDidCancel(_ controller : ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func allListsViewControllerDelegate(_ controller : ListDetailViewController, didFinishAdding item: Checklist) {
        let newIndex = dataModel!.lists.count
        dataModel!.lists.append(item)
        let indexPath = IndexPath(row: newIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        dismiss(animated: true, completion: nil)
    }
    
    func allListsViewControllerDelegate(_ controller : ListDetailViewController, didFinishEditing item: Checklist) {
        if let index = dataModel!.lists.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = item.text
            }
        }
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel!.lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let nav_controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! UINavigationController
        let controller = nav_controller.topViewController as! ListDetailViewController
        let item = dataModel!.lists[indexPath.row]
        controller.delegate = self
        controller.checklistToEdit = item
        
        present(nav_controller, animated: true, completion: nil)
    }
    
    //MARK: Navigation Delegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            dataModel.indexOfSelectedIndex = -1
        }
    }
    
}
