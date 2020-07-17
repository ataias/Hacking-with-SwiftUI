//
//  CoreUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 17/07/20.
//
//

import Foundation
import CoreData


extension CoreUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreUser> {
        return NSFetchRequest<CoreUser>(entityName: "CoreUser")
    }

    @NSManaged public var data: String?
    @NSManaged public var id: UUID?

}
