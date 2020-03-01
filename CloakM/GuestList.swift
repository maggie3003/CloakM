//
//  GuestList.swift
//  CloakM
//
//  Created by Meiqi You on 20/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI

struct GuestList: View {
   // @Environment(\.managedObjectContext) var managedObjectContext
    //@FetchRequest(fetchRequest: Guest.getALLGuests()) var guests:FetchedResults<Guest>
    @State private var newGuest = ""
    
    var body: some View {
        NavigationView{
            Text("show something")
            List{
                Section(header: Text("Guests")){
                    HStack{
                        TextField("New", text:self.$newGuest)
                       /* Button(action:{}){
                            Image(systemName: "plus.circle.fill")
                            
                        }*/
                    }.frame(height:10)
                }
            }.environment(\.defaultMinListRowHeight, 10)
        }
    }
}

struct GuestList_Previews: PreviewProvider {
    static var previews: some View {
        GuestList()
    }
}
