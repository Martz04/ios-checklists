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
    var iconName = "No Icon"
    
    convenience init(name text: String) {
        self.init(name: text, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) {
        self.text = name;
        self.iconName = iconName
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: CONST.valueFor(.Text))
        aCoder.encode(items, forKey: CONST.valueFor(.Item))
        aCoder.encode(iconName, forKey: CONST.valueFor(.IconName))
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: CONST.valueFor(.Text)) as! String
        iconName = aDecoder.decodeObject(forKey: CONST.valueFor(.IconName)) as! String
        items = aDecoder.decodeObject(forKey: CONST.valueFor(.Item)) as! [ChecklistItem]
    }
    
    func countUncheckedItems() -> Int {
        return items.reduce(0, {cnt, item in cnt + (item.checked ? 0 : 1)})
    }
    
    func sortChecklistsByDate() {
        items.sort(by: { item1, item2 in
            item1.dueDate < item2.dueDate
        })
    }
}
