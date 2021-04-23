//
//  ProjectModels.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import Foundation
import CoreData

public class Project: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var price: String?
    @NSManaged public var title: String?
    @NSManaged public var persons: NSSet?
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

}

//MARK:- Methods of project
extension Project {
    static func getAllProject()-> NSFetchRequest<Project> {
        let req = Project.fetchRequest() as! NSFetchRequest<Project>
        let sort = NSSortDescriptor(key: "title", ascending: true)
        req.sortDescriptors = [sort]
        return req
    }
    
    static func getProjectByEmail(email: String)-> NSFetchRequest<Project> {
        let request = self.getAllProject()
        let pred = NSPredicate(format: "persons.email CONTAINS %@", email as NSString)
        request.predicate = pred
        return request
    }
    
    static func getAllUsersProjects()-> NSFetchRequest<Project> {
        let email = UserDefaults.standard.string(forKey: "userLogin")!
        let request = self.getAllProject()
        let pred = NSPredicate(format: "persons.email CONTAINS %@", email as NSString)
        request.predicate = pred
        return request
    }
    
    
    static func addToProject(context: NSManagedObjectContext, id: UUID) {
        let request = self.getAllProject()
        let pred = NSPredicate(format: "id CONTAINS %@", id as CVarArg)
        request.predicate = pred
        let result = try? context.fetch(request)
        if result == nil {
            return
        }
        
    }
    
    static func addNewProject(context: NSManagedObjectContext, title: String, price: String) {
        let userFetch = UserModels.getUserByEmail(email: UserDefaults.standard.string(forKey: "userLogin")!)
        let userRes = try? context.fetch(userFetch)
        guard let logedUser = userRes?[0] else {return}
        
        let newProject = Project(context: context)
        newProject.title = title
        newProject.price = price
        newProject.addToPersons(logedUser)
        try! context.save()
    }
}
