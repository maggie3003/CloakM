//
//  ContentView.swift
//  CloakM
//
//  Created by Meiqi You on 19/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI
import CoreData
import UIKit



struct ContentView: View {
    @State var newPatron = false
    @State var show = false
    //@FetchRequest(entity:Guest.entity(),sortDescriptors: [])var guests:FetchedResults<Guest>
   @Environment(\.managedObjectContext) var managedObjectContext
    @State var admin = false
    @State var checkout = false
    
    var body: some View {
        
        VStack{
            /*
            Button("Add Patron"){
                self.show = true
            }
            .sheet(isPresented: $show, content:{GuestList()})
            .padding()
        
        
            Button("Check In"){
                self.newPatron = true
            }
            .sheet(isPresented: $newPatron, content:{enterNumber()})
            .padding()
            
            Button("Check Out"){
                self.checkout = true
            }
            .sheet(isPresented: $checkout, content:{CheckOut()})
            .padding()
            
            Button(action: {
                self.admin = true
            }) {
                Text("Admin Panel")
            }.sheet(isPresented: $admin, content: {AdminPanel()})*/
            
            NavigationView{
                VStack{
                    NavigationLink(destination: GuestList()){
                        Text("Quick Add Patron")
                    }.navigationBarTitle(Text("Home"))
                NavigationLink(destination: enterNumber()){
                    Text("Check In")
                }.navigationBarTitle(Text("Home"))
                    NavigationLink(destination: CheckOut()){
                        Text("Check Out")
                    }.navigationBarTitle(Text("Home"))
                    NavigationLink(destination: AdminPanel()){
                        Text("Admin Panel")
                    }.navigationBarTitle(Text("Home"))
                  
            }
            }
            
        }
    }
}
    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
