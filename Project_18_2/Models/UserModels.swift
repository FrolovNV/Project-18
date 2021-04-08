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
}

//MARK:-UserModels query
extension UserModels {
    
    static func getUserWithEmail()->NSFetchRequest<UserModels> {
        let req = UserModels.fetchRequest() as! NSFetchRequest<UserModels>
        let sort = NSSortDescriptor(key: "email", ascending: true)
        req.sortDescriptors = [sort]
        return req
    }
    
}
