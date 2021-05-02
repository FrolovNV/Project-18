//
//  Tasks.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 26.04.2021.
//

import Foundation


import Foundation
import CoreData

public class Tasks: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var priceDollar: Int64
    @NSManaged public var priceCent: Int64
    @NSManaged public var project: Project?
    
    @NSManaged public var favorite: Bool
    @NSManaged public var creatingDate: Date
    @NSManaged public var complitedDate: Date?
    
    @NSManaged public var person: UserModels?
}

