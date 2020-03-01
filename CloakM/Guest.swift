//
//  Guest.swift
//  CloakM
//
//  Created by Meiqi You on 19/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import Foundation
import CoreData

public class Guest:NSManagedObject, Identifiable{
    @NSManaged public var name:String?
    @NSManaged public var number:String?
    @NSManaged public var email:String?
    @NSManaged public var gender:String?
    @NSManaged public var birthday:Date?
}

extension Guest {
    static func getALLGuests() -> NSFetchRequest<Guest> {
        let request:NSFetchRequest<Guest> = Guest.fetchRequest() as! NSFetchRequest<Guest>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
}
