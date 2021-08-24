//
//  Exist.swift
//  CloakM
//
//  Created by Maggie Q on 21/7/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

//this view is not used anywhere
import SwiftUI

struct Exist: View {
    @State var existed = false
    
    var body: some View {
        VStack{
        Text("Is this you?")
        HStack{
            Button("Yes"){
                self.existed = true
            }
               /* .sheet(isPresented: $existed, content:{CheckinItem()})
            */
            
            Button("No"){
                self.existed = false
            }
                .sheet(isPresented: $existed, content:{GuestList()})
            
            }
        
        }
    }
}

struct Exist_Previews: PreviewProvider {
    static var previews: some View {
        Exist()
    }
}
