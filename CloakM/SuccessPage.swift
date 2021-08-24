//
//  SuccessPage.swift
//  CloakM
//
//  Created by Maggie Q on 9/8/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI

struct SuccessPage: View {
    @State var showsheet = false
    
    var body: some View {
        VStack{
            NavigationView {
                NavigationLink(destination: ContentView()) { Text("homepage") }
            }.frame(height: 20)
            
            
            Text("Check in succeeded!")
            Button(action: {
                self.showsheet = true
            }) {
                Text("Check in another")
            }.sheet(isPresented: self.$showsheet, content: {enterNumber()})
            
           
        }
    }
}

struct SuccessPage_Previews: PreviewProvider {
    static var previews: some View {
        SuccessPage()
    }
}
