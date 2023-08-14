//
//  HoldedTrash.swift
//  ARtestt
//
//  Created by David Mahbubi on 10/08/23.
//
//

let trashCategories: [TrashType: [String]] = [
    .organic: ["Banana", "Apple", "Leaf"],
    .nonOrganic: ["Plastic", "Bottle"],
    .medical: ["Mask", "Medicine"]
]

struct HoldedTrash {
    
    var name: String
    var category: TrashType?
    
    init(name: String) {
        self.name = name
        self.category = self.getType()
    }
    
    private func getType() -> TrashType? {
        for (k, v) in trashCategories {
            if (v.contains(name)) {
                return k
            }
        }
        return nil
    }
}
