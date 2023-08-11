//
//  HoldedTrash.swift
//  ARtestt
//
//  Created by David Mahbubi on 10/08/23.
//

import Foundation

enum TrashType {
    case organic
    case nonOrganic
    case medical
}

let trashCategories: [TrashType: [String]] = [
    .organic: ["Banana", "Apple", "Leaf"],
    .nonOrganic: ["Plastic", "Bottle"],
    .medical: ["Mask", "Medicine"]
]

struct HoldedTrash {
    
    var name: String
    
    func getType() -> TrashType? {
        for (k, v) in trashCategories {
            if (v.contains(name)) {
                return k
            }
        }
        return nil
    }
}
