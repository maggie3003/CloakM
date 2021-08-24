//
//  PatronDetail.swift
//  CloakM
//
//  Created by Maggie Q on 26/7/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI
import CoreData

struct PatronDetail: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var guest = ""
    @State var number = ""
    @State var email = ""
    @State var gender = ""
    @State var birthday = ""
    @State var genders = ["Male","Female"]
    @State private var selectorIndex = 0
    
    var body: some View {
        VStack{
            Text("Please Enter Your Detail")
                .padding()
            HStack{
                Text("Name: ")
                TextField("Name", text:$guest).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Number: ")
                TextField("Number",text: $number).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Email: ")
                TextField("Email",text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack{
                Text("Gender: ")
                Picker("Gender",selection: $selectorIndex) {
                    ForEach(0..<genders.count){ index in
                        Text(self.genders[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Text("Value: \(genders[selectorIndex])")
            HStack{
                Text("Birthday: ")
                TextField("Birthday",text: $birthday).textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            
            Button(action:{
                let patron = Guest(context: self.managedObjectContext)
                patron.guest = "Jane Doe"
                patron.birthday="05/03/2000"
                patron.email="test@gmail.com"
                patron.number="0450123123"
                patron.gender="Female"
                
                do{
                    try self.managedObjectContext.save()
                }catch{
                    //handle core data error
                }
            }){
                Text("Insert example language")
            }
        }
    }
}

struct PatronDetail_Previews: PreviewProvider {
    static var previews: some View {
        PatronDetail()
    }
}
