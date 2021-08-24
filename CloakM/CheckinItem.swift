//
//  CheckinItem.swift
//  CloakM
//
//  Created by Maggie Q on 21/7/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI
import CoreData

struct CheckinItem: View {
    @State var item = 0
    @State var showsheet = false
    @Binding var pName : String
    @Binding var pNumber: String
    @State var ticket = 0
    @State var checkins:[NSManagedObject] = []

    
    var body: some View {
        VStack{
        Text("Hi, \(pName), how many items do you want to check-in?")
            Stepper("\(item)", onIncrement: {
                self.item += 1
                print("Adding to age")
            }, onDecrement: {
                self.item -= 1
                print("Subtracting from age")
            })
                .padding(.horizontal, 300)
            Button(action: {
                print("there are \(self.item) items")
                self.saveCheckin()
                self.showsheet = true
            }) {
                Text("Submit")
            }.sheet(isPresented: self.$showsheet, content: {SuccessPage()})
        }
    }
    
    func saveCheckin(){
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MM y"
        let currentTime = formatter.string(from: now)
        print("current time is \(currentTime).")
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Checkin",
                                       in: managedContext)!
        
        let newCheckin = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Checkin")
        
        do{
            checkins = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("Could not fetch checkinlist")
        }
        
        ticket = checkins.count + 1
        
        newCheckin.setValue($pName.wrappedValue, forKeyPath: "cpname")
        newCheckin.setValue(String($item.wrappedValue), forKey: "cpitem")
        newCheckin.setValue($pNumber.wrappedValue, forKey: "cpnumber")
        newCheckin.setValue(currentTime, forKey: "cptime")
        newCheckin.setValue(String($ticket.wrappedValue), forKey: "cpticket")
        
        do {
            try managedContext.save()
            print("saved successfully -- \($pName.wrappedValue) -- \($ticket.wrappedValue)")
            //self.loadPotatos()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
/*
struct CheckinItem_Previews: PreviewProvider {
    
    static var previews: some View {
        CheckinItem()
    }
}
*/
