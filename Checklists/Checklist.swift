//
//  Checklist.swift
//  Checklists
//
//  Created by Mario Alberto Gonzalez on 30/01/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import Foundation

class Checklist: NSObject, NSCoding {
    var text: String
    var items = [ChecklistItem]()
    
    init(name text: String) {
        self.text = text;
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(items, forKey: "Items")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
    }
}
