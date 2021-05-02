//
//  ProjectModels.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import Foundation
import CoreData
import UIKit

public class Project: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var price: String?
    @NSManaged public var title: String?
    @NSManaged public var creatingDate: Date
    @NSManaged public var complitionDate: Date?
    @NSManaged public var favorite: Bool
    @NSManaged public var persons: NSSet?
    @NSManaged public var tasks: NSSet?
}

//MARK:- Add User to Project
extension Project {
    @objc(addPersonsObject:)
    @NSManaged public func addToPersons(_ value: UserModels)

    @objc(removePersonsObject:)
    @NSManaged public func removeFromPersons(_ value: UserModels)

    @objc(addPersons:)
    @NSManaged public func addToPersons(_ values: NSSet)

    @objc(removePersons:)
    @NSManaged public func removeFromPersons(_ values: NSSet)
    
    
    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Tasks)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Tasks)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

