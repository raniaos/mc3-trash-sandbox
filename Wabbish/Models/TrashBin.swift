//
//  TrashBin.swift
//  ARtestt
//
//  Created by David Mahbubi on 14/08/23.
//

let trashBinCategories: [TrashType: String] = [
    .paper: "PaperTrashBox",
    .organic: "OrganicTrashBox",
    .b3: "B3TrashBox",
    .anorganic: "AnorganicTrashBox",
    .residu: "ResiduTrashBox"
]

struct TrashBin {
    
    let name: String
    var trashBinCategory: TrashType? = nil
    
    init(name: String) {
        self.name = name
        self.trashBinCategory = determineType()
    }
    
    private func determineType() -> TrashType? {
        for (k, v) in trashBinCategories {
            if (v == self.name) {
                return k
            }
        }
        
        return nil
    }
}
