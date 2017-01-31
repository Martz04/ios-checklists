//
//  Checklist.swift
//  Checklists
//
//  Created by Mario Alberto Gonzalez on 30/01/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import Foundation

class Checklist: NSObject {
    var text: String
    
    init(name text: String) {
        self.text = text;
    }
}
