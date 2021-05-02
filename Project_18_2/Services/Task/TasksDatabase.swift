//
//  TasksDatabase.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 26.04.2021.
//

import Foundation
import CoreData


class TasksDatabase {
    
    static let shared = TasksDatabase()
    
    let allTasks: NSFetchRequest<Tasks> = {
        let req = Tasks.fetchRequest() as! NSFetchRequest<Tasks>
        let sort = NSSortDescriptor(key: "title", ascending: true)
        req.sortDescriptors = [sort]
        return req
    }()
    
    
    func getAllTaskOfProject(project: Project)-> NSFetchRequest<Tasks> {
        let req = self.allTasks
        let predicate = NSPredicate(format: "project.id CONTAINS %@", project.id! as CVarArg)
        req.predicate = predicate
        return req
    }
}
