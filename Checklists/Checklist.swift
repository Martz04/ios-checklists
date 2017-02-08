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
        aCoder.encode(text, forKey: CONST.valueFor(.Text))
        aCoder.encode(items, forKey: CONST.valueFor(.Item))
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: CONST.valueFor(.Text)) as! String
        items = aDecoder.decodeObject(forKey: CONST.valueFor(.Item)) as! [ChecklistItem]
    }
}
