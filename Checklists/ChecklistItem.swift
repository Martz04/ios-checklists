//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Mario Alberto Gonzalez on 26/01/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleCheck() {
        checked = !checked
    }
}
