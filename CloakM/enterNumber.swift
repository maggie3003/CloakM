//
//  enterNumber.swift
//  CloakM
//
//  Created by Meiqi You on 21/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI
import CoreData

struct enterNumber: View {
    @State var number: String = " "
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Guest.entity(), sortDescriptors:[NSSortDescriptor(keyPath: \Guest.guest,ascending:true)]) var guestnames: FetchedResults<Guest>
    @State var exist = false
    @State var patronName = ""
    @State var patrons:[NSManagedObject] = []
    enum ActiveSheet{
        case first, second
    }
    @State var activeSheet: ActiveSheet = .first
    @State var isYou = false
    @State var notYou = false
    
    var body: some View {
       VStack{
           Text("Your Number")
           TextField("Number", text:$number).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(100)
        
          Button(action: {
               
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                       return
                   }
                   let managedContext = appDelegate.persistentContainer.viewContext
            
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Patron")
                  fetchRequest.predicate = NSPredicate(format: "pnumber = %@", self.$number.wrappedValue)
           
                
            do {
                //self.patrons = try managedContext.fetch(fetchRequest)
                let fetchReturn = try managedContext.fetch(fetchRequest)
               
                //if 不存在，go to guestlist, else is it you?
               // print("fetchReturn is \(fetchReturn)")
                if fetchReturn.count == 0 {
                    self.exist = true
                    self.activeSheet = .first
                    print("------Patron not found------")
                } else{
                    self.exist = true
                    self.activeSheet = .second
                     let objectPatron = fetchReturn[0]
                    self.patronName = objectPatron.value(forKey: "pname") as? String ?? "Patron Name"
                   
                    print("------Patron found------ \(self.patronName)")
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
                   print(fetchRequest)
                             
          }){
              Text("Submit")
                  .foregroundColor(.green)
                  .font(.system(size: 22))
        
          }.sheet(isPresented: $exist){
            if self.activeSheet == .first{
                GuestList()
                
            }else{
               VStack{
                Text("Are You \(self.patronName)?")
                       HStack{
                           Button("Yes"){
                            self.isYou = true
                           }
                           .sheet(isPresented: self.$isYou, content:{CheckinItem(pName: self.$patronName,pNumber: self.$number)})
                           
                           //create new patron and delete the existing one
                           Button("No"){
                            self.notYou = true
                           }
                           .sheet(isPresented: self.$notYou, content:{GuestList()})
                           
                           }
                       
                       }
            }
        }
           
        
        
        
       }
    }
    
   
    
    
   

}



struct enterNumber_Previews: PreviewProvider {
    static var previews: some View {
        enterNumber()
    }
}
