//
//  HoldedTrash.swift
//  ARtestt
//
//  Created by David Mahbubi on 10/08/23.
//
//

let trashCategories: [TrashType: [String]] = [
    .organic: ["Banana"],
    .anorganic: ["Bottle"],
    .b3: ["Battery"],
    .paper: ["Paper"],
    .residu: ["Mask"],
]

struct HoldedTrash {
    
    var name: String
    var category: TrashType?
    
    init(name: String, icon: String?) {
        self.name = name
        self.category = self.determineType()
    }
    
    private func determineType() -> TrashType? {
        for (k, v) in trashCategories {
            if (v.contains(name)) {
                return k
            }
        }
        return nil
    }
}
