//
//  DataModel.swift
//  Checklists
//
//  Created by Mario Alberto Gonzalez on 05/02/17.
//  Copyright © 2017 Mario Alberto Gonzalez. All rights reserved.
//

import Foundation

enum CONST: String {
    case Checklists = "Checklists"
    case Plist = "Checklists.plist"
    case Text = "Text"
    case Item = "Items"
    case Index = "ChecklistIndex"
    
    static func valueFor(_ const:CONST) -> String {
        return const.rawValue
    }
}

class DataModel {
    var lists = [Checklist]()
    
    init() {
        loadChecklistData()
        registerDefaults()
    }
    
    var indexOfSelectedIndex: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
        }
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
    }
    
    func registerDefaults() {
        let dictionary: [String: Any] = ["ChecklistIndex": -1]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent(CONST.valueFor(.Plist))
    }
    
    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: CONST.valueFor(.Checklists))
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadChecklistData() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unarchiver.decodeObject(forKey: CONST.valueFor(.Checklists)) as! [Checklist]
            unarchiver.finishDecoding()
        }
    }

}
