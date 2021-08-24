//
//  CheckOut.swift
//  CloakM
//
//  Created by Maggie Q on 10/8/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI
import CoreData
import UIKit

struct CheckOut: View {
    @State var ticket = ""
    @State var checkins:[NSManagedObject] = []
    @State var showSheet = false
    @State var modifyingPatron:String? = nil
    
    var body: some View {
        VStack{
            HStack{
                TextField("Your Ticket Number",text:$ticket).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(100)
                
                Button(action:{
                    self.searchCheckin(ticket:self.ticket)
                    //self.loadCheckin()
                }){
                    Text("Search")
                }
                
                }
                .padding(50)
                    
            ForEach(checkins, id: \.self){ thisCheck in
                Button(action:{
                    self.modifyingPatron = (thisCheck as? Checkin)?.cpname ?? "Patron name error"
                    self.showSheet = true
                }){
                    
                    HStack{
                        Text("Ticket:     ")
                        Text((thisCheck as? Checkin)?.cpticket ?? "Ticket number error")
                    
                    }
                }
         .sheet(isPresented: self.$showSheet){
             VStack{
                HStack{
                    Text((thisCheck as? Checkin)?.cpticket ?? "Ticket number error")
                    Text((thisCheck as? Checkin)?.cpname ?? "Patron name error")
                    
                }
                 
                 HStack{
                     Button(action: {
                         if let checkinToModify = self.modifyingPatron {
                             self.delete(thisPatronString: checkinToModify)
                            self.showSheet = false
                         }
                     }) {
                         Text("Delete Patron")
                     }
                     
                 }
             }.padding()
                 .background(Color.init(white: 0.9))
                 .cornerRadius(10)
                 .padding()
         }
                .background(Color.red)
            
            }
        }
    }
    
    func delete(thisPatronString:String){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Checkin")
        fetchRequest.predicate = NSPredicate(format: "cpname = %@", thisPatronString)
        
        do {
            let fetchReturn = try managedContext.fetch(fetchRequest)
            
            let objectDelete = fetchReturn[0] as! NSManagedObject
            managedContext.delete(objectDelete)
            do {
                try managedContext.save()
                print("deleted successfully")
               self.loadCheckin()
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func searchCheckin(ticket:String){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Checkin")
        fetchRequest.predicate = NSPredicate(format: "cpticket = %@", ticket)
        
        do {
            checkins = try managedContext.fetch(fetchRequest)
            
            //self.showSheet = true
            print("there are \(checkins.count) tickets.")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadCheckin(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Checkin")
        
        do {
            checkins = try managedContext.fetch(fetchRequest)
            //self.showSheet = false
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

struct CheckOut_Previews: PreviewProvider {
    static var previews: some View {
        CheckOut()
    }
}
