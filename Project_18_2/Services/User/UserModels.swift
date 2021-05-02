//
//  UserModels.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 06.04.2021.
//

import Foundation
import CoreData
import UIKit


public class UserModels: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var email: String
    @NSManaged public var password: String
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var mobile: String?
    @NSManaged public var image: Data?
    
    @NSManaged public var teams: NSSet?
    @NSManaged public var task: NSSet?
    
    
    public var uiImage: UIImage {
        guard let imageData = self.image,
              let uiImage = UIImage(data: imageData) else {
            return UIImage(named: "Person")!
        }
        return uiImage
    }
}

extension UserModels {

    @objc(addTeamsObject:)
    @NSManaged public func addToTeams(_ value: Project)

    @objc(removeTeamsObject:)
    @NSManaged public func removeFromTeams(_ value: Project)

    @objc(addTeams:)
    @NSManaged public func addToTeams(_ values: NSSet)

    @objc(removeTeams:)
    @NSManaged public func removeFromTeams(_ values: NSSet)
    
    @objc(addTaskObject:)
    @NSManaged public func addToTask(_ value: Tasks)

    @objc(removeTaskObject:)
    @NSManaged public func removeFromTask(_ value: Tasks)

    @objc(addTask:)
    @NSManaged public func addToTask(_ values: NSSet)

    @objc(removeTask:)
    @NSManaged public func removeFromTask(_ values: NSSet)

}
