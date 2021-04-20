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

//MARK:-UserModels query
extension UserModels {
    
    static func getAllUsers()->NSFetchRequest<UserModels> {
        let req = UserModels.fetchRequest() as! NSFetchRequest<UserModels>
        let sort = NSSortDescriptor(key: "email", ascending: true)
        req.sortDescriptors = [sort]
        return req
    }
    
    static func getUserByEmail(email: String)-> NSFetchRequest<UserModels> {
        let request = self.getAllUsers()
        let pred = NSPredicate(format: "email CONTAINS %@", email as NSString)
        request.predicate = pred
        return request
    }
}
