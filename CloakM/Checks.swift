//
//  Checkin.swift
//  CloakM
//
//  Created by Meiqi You on 20/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import Foundation
import CoreData

public class Checks:NSManagedObject,Identifiable{
    @NSManaged public var citem:Int16
    @NSManaged public var cname:String?
    @NSManaged public var cnumber:UUID
    @NSManaged public var ctime:String?
     
}

extension Checks {
    static func getAllCheckins() -> NSFetchRequest<Checks>{
        let request:NSFetchRequest<Checks> = NSFetchRequest<Checks>(entityName: "Checks") 
        
        let sortDescriptor = NSSortDescriptor(key: "cnumber", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
}
