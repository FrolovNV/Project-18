//
//  ProjectDatabase.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 26.04.2021.
//

import Foundation
import CoreData


class ProjectDatabase {
    static let shared = ProjectDatabase()
    
    let allProjectFetchRequest: NSFetchRequest<Project> = {
        let req = Project.fetchRequest() as! NSFetchRequest<Project>
        let sort = NSSortDescriptor(key: "title", ascending: true)
        req.sortDescriptors = [sort]
        return req
    }()
    
    func getProjectByEmail(email: String)-> NSFetchRequest<Project> {
        let request = self.allProjectFetchRequest
        let pred = NSPredicate(format: "persons.email CONTAINS %@", email as NSString)
        request.predicate = pred
        return request
    }
    
    func getAllUsersProjects()-> NSFetchRequest<Project> {
        let email = UserDefaults.standard.string(forKey: "userLogin")!
        let request = self.allProjectFetchRequest
        let pred = NSPredicate(format: "persons.email CONTAINS %@", email as NSString)
        request.predicate = pred
        return request
    }
    
    
    func addToProject(context: NSManagedObjectContext, id: UUID) {
        let request = self.allProjectFetchRequest
        let pred = NSPredicate(format: "id CONTAINS %@", id as CVarArg)
        request.predicate = pred
        let result = try? context.fetch(request)
        if result == nil {
            return
        }
        
    }
    
    func addNewProject(context: NSManagedObjectContext, user: UserModels, title: String, price: String) {
        let userFetch = UserDatabase.shared.getUserByEmail(email: UserDefaults.standard.string(forKey: "userLogin")!)
        let userRes = try? context.fetch(userFetch)
        guard let logedUser = userRes?[0] else {return}
        
        let newProject = Project(context: context)
        newProject.id = UUID()
        newProject.title = title
        newProject.price = price
        newProject.creatingDate = Date()
        newProject.favorite = false
        newProject.addToPersons(logedUser)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func changeFavoriteStatus(context: NSManagedObjectContext, project: Project) {
        project.favorite.toggle()
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func projectDone(context: NSManagedObjectContext, project: Project) {
        project.complitionDate = Date()
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteThisProject(context: NSManagedObjectContext, project: Project) {
        context.delete(project)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    func addNewIntoProjectTask(context: NSManagedObjectContext, project: Project, person: UserModels, title: String) {
        
        let newTask = Tasks(context: context)
        newTask.id = UUID()
        newTask.title = title
        newTask.priceDollar = 0
        newTask.priceCent = 0
        
        person.addToTask(newTask)
        project.addToTasks(newTask)
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
}
