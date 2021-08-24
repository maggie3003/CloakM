//
//  GuestList.swift
//  CloakM
//
//  Created by Meiqi You on 20/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI
import CoreData

struct GuestList: View{
    //@Environment(\.managedObjectContext) var managedObjectContext
    //@ObservedObject var observedData = observable()
       @State var guest = ""
       @State var number = ""
       @State var email = ""
       @State var gender = ""
       @State var birthday = ""
       @State var genders = ["Male","Female"]
       @State private var selectorIndex = 0
       @State var patrons:[NSManagedObject] = []
       @State var showSheet = false
       @State var modifyingPatron:String? = nil
    
    @State var newPatronName = ""
    @State var newPatronNumber = ""
    @State var newPatronEmail = ""
    @State var newPatronGender = ""
    @State var newPatronBirthday = ""
    
    
    var body: some View {
        VStack{
            Text("Guest List")
            VStack{
                HStack{
                    Text("Name: ")
                    TextField("Name", text:self.$guest).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Number: ")
                    TextField("Number",text: self.$number).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Email: ")
                    TextField("Email",text:self.$email).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack{
                    Text("Gender: ")
                    Picker("Gender",selection: self.$selectorIndex) {
                        ForEach(0..<2){ index in
                            Text(self.genders[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Text("Gender: \(genders[selectorIndex])")
                HStack{
                    Text("Birthday: ")
                    TextField("Birthday",text: self.$birthday).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                            
                Button(action: {
                    self.addNewPatron()
                }) {
                    Text("Add New")
                }

            }.padding(50)

              /*  List{
                    ForEach(self.observedData.data){i in
                        HStack{
                            Text(i.self.guest)
                            Text(i.number)
                            Text(i.gender)
                        }
                    }
                }*/
                
                ForEach(patrons, id: \.self){ thisPatron in
                    
                    Button(action: {
                        self.newPatronName = (thisPatron as? Patron)?.pname ?? "patron name error"
                        self.modifyingPatron = (thisPatron as? Patron)?.pname ?? "patron name delete fetch error"
                        self.number = (thisPatron as? Patron)?.pnumber ?? "patron number error"
                        self.birthday = (thisPatron as? Patron)?.pbirthday ?? "patron birthday error"
                        self.gender = (thisPatron as? Patron)?.pgender ?? "patron gender error"
                        self.email = (thisPatron as? Patron)?.pemail ?? "patron email error"
                       // self.selectorIndex = (thisPatron as? Patron)?. ?? 0
                        self.showSheet = true
                    }) {
                        Text((thisPatron as? Patron)?.pname ?? "patron name error")
                          .frame(width:200, height:20)
                          .background(Color.white)
                    }.sheet(isPresented: self.$showSheet){
                            VStack{
                                Text("Patron Detail")
                                TextField("Name: \(self.$guest.wrappedValue)", text: self.$newPatronName)
                                                           .padding(.horizontal, 20)
                                                           .background(Color.white)
                                  .foregroundColor(.black)
                                TextField("Number: \(self.$number.wrappedValue)", text: self.$newPatronNumber)
                                                           .padding(.horizontal, 20)
                                                           .background(Color.white)
                                .foregroundColor(.black)
                                TextField("Email: \(self.$email.wrappedValue)", text: self.$newPatronEmail)
                                                           .padding(.horizontal, 20)
                                                           .background(Color.white)
                                .foregroundColor(.black)
                                TextField("Gender: \(self.$gender.wrappedValue)", text: self.$newPatronGender)
                                                           .padding(.horizontal, 20)
                                                           .background(Color.white)
                                .foregroundColor(.black)
                                TextField("Birthday: \(self.$birthday.wrappedValue)", text: self.$newPatronBirthday)
                                                           .padding(.horizontal, 20)
                                                           .background(Color.white)
                                .foregroundColor(.black)
                                                      
                                Button(action: {
                                    if let patronToModify = self.modifyingPatron {
                                            self.deletePatron(thisPatronString: patronToModify)
                                    }
                                }) {
                                    Text("Delete Patron")
                                }
                                .padding(20)
                                Button(action: {
                                    if let patronToModify = self.modifyingPatron {
                                        self.updatePatron(currentPatronString: patronToModify, newPatronString: self.$newPatronName.wrappedValue)
                                    }
                                }) {
                                    Text("Update Patron")
                                }.padding(20)
                            }
                            
                        
                        
                       
                    }
                
          
            }
            /*      HStack{
                    Button(action: {
                        if let patronToModify = self.modifyingPatron {
                            self.deletePatron(thisPatronString: patronToModify)
                        }
                    }) {
                        Text("Delete Potato")
                    }
                    Button(action: {
                        if let potatoToModify = self.modifyingPatron {
                            self.updatePotato(currentPotatoString: potatoToModify, newPotatoString: self.$newPotatoString.wrappedValue)
                        }
                        
                        
                    }) {
                        Text("Update Potato")
                    }
                }
            }.padding()
                .background(Color.init(white: 0.9))
                .cornerRadius(10)
                .padding() */
            
            
        }.onAppear(){
            self.loadPatron()
        }
    
        
    }
    
    func addNewPatron(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Patron", in: managedContext)!
        
        let newPatron = NSManagedObject(entity: entity, insertInto:managedContext)
        
        newPatron.setValue($guest.wrappedValue, forKeyPath: "pname")
        newPatron.setValue($number.wrappedValue, forKeyPath: "pnumber")
        newPatron.setValue($email.wrappedValue, forKeyPath: "pemail")
        newPatron.setValue($genders[selectorIndex].wrappedValue, forKeyPath: "pgender")
        newPatron.setValue($birthday.wrappedValue, forKeyPath: "pbirthday")
        newPatron.setValue($selectorIndex.wrappedValue, forKeyPath: "genderindex")
        
        do{
            try managedContext.save()
            print("saved successfully -- \(self.$guest.wrappedValue) -- \(self.$gender.wrappedValue)")
            self.loadPatron()
        }catch let error as NSError{
            print("Could not save. \(error),\(error.userInfo)")
        }
    }
    
        func loadPatron(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Patron")
        
        do {
            patrons = try managedContext.fetch(fetchRequest)
            self.showSheet = false
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deletePatron(thisPatronString:String){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Patron" )
            fetchRequest.predicate = NSPredicate(format: "pname = %@", thisPatronString)
        
            do{
                let fetchReturn = try managedContext.fetch(fetchRequest)
                
                let objectDelete = fetchReturn[0] as! NSManagedObject
                managedContext.delete(objectDelete)
                do{
                    try  managedContext.save()
                    print("deleted successfully!")
                    self.loadPatron()
                }catch let error as NSError{
                    print("Could not delete. \(error), \(error.userInfo)")
                }
            } catch let error as NSError{
                print("Could not fetch. \(error), \(error.userInfo)")
                
        }
    }
    
    func updatePatron(currentPatronString:String, newPatronString:String){
        
    }
}



class observable: ObservableObject{
    @Published var data = [datatype]()
    
    func addData(guest: String,number:String,email:String,gender:String,birthday:String){
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Guest", into: context)
        entity.setValue(guest, forKey: "guest")
        entity.setValue(number, forKey: "number")
        entity.setValue(email, forKey: "email")
        entity.setValue(gender, forKey: "gender")
        entity.setValue(birthday, forKey: "birthday")
        
        
        do{
           
            try context.save()
            print("success" + "\(entity.objectID)")
            data.append(datatype(id:entity.objectID,guest:guest,number:number,email:email,gender:gender,birthday:birthday))
        }
        catch{
            
            print(error.localizedDescription)
        }
        
    }
    
}

struct datatype: Identifiable{
    var id: NSManagedObjectID
    public var guest: String
    public var number: String
    public var email: String
    public var gender: String
    public var birthday:String
}



struct GuestList_Previews: PreviewProvider {
    static var previews: some View {
        GuestList()
    }
}
