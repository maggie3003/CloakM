//
//  ContentView.swift
//  CloakM
//
//  Created by Meiqi You on 19/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        //Text("Hello, World!")
        VStack{
            NavigationView{
                NavigationLink(destination: GuestList()){
                    Text("check guests")
                }.buttonStyle(PlainButtonStyle())
            }
            NavigationView{
                NavigationLink(destination: CheckinList()){
                    Text("check checkins")
                }.buttonStyle(PlainButtonStyle())
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
