//
//  UserDatabase.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 26.04.2021.
//

import Foundation
import CoreData


class UserDatabase {
    static let shared = UserDatabase()
    
    func getAllUsers()->NSFetchRequest<UserModels> {
        let req = UserModels.fetchRequest() as! NSFetchRequest<UserModels>
        let sort = NSSortDescriptor(key: "email", ascending: true)
        req.sortDescriptors = [sort]
        return req
    }
    
    func getUserByEmail(email: String)-> NSFetchRequest<UserModels> {
        let request = self.getAllUsers()
        let pred = NSPredicate(format: "email CONTAINS %@", email as NSString)
        request.predicate = pred
        return request
    }
}
