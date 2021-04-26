//
//  UserModels.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 06.04.2021.
//

import Foundation
import CoreData


public class UserModels: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var email: String
    @NSManaged public var password: String
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var mobile: String?
    @NSManaged public var image: Data?
}
