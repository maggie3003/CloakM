//
//  enterNumber.swift
//  CloakM
//
//  Created by Meiqi You on 21/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI

struct enterNumber: View {
    @State var number: String = " "
    var body: some View {
        VStack{
            TextField("Enter your number", text: $number)
            Text("\(number)")
        }.padding()
            .font(.title)
    }
   
}

struct enterNumber_Previews: PreviewProvider {
    static var previews: some View {
        enterNumber()
    }
}
