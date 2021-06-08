//
//  Item.swift
//  IosWeather
//
//  Created by Daniel Marceta on 20.04.21.
//

import Foundation
import CoreData

extension Item{
    static func getAllItems() -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dt", ascending: true)]
        return request
    }
}
