//
//  CheckinList.swift
//  CloakM
//
//  Created by Meiqi You on 20/2/20.
//  Copyright © 2020 Maggie@Tang. All rights reserved.
//

import SwiftUI

struct CheckinList: View {
       //@Environment(\.managedObjectContext) var managedObjectContext2
       //@FetchRequest(fetchRequest: Checks.getAllCheckins()) var checkins:FetchedResults<Checks>
     //  @State private var newCheckin = ""
        var entries = checkinList
       //@ObservedObject var oneCheckin = enterNumber()
    
    var body: some View {
        NavigationView{
            Text("come on!")
            List {
                Text("show something?")
                ForEach(entries) { item in
                    NavigationLink(destination: enterNumber())
                    {
                        VStack {
                            HStack{
                                Text("number")
                                Text("name")
                                Text("item")
                            }
                            HStack{
                                Text(self.entries[0].id.uuidString)
                                Text(self.entries[0].name)
                                Text(self.entries[0].item)
                                Text(self.entries[0].time)
                            }
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("Updates")
            .navigationBarItems(trailing:
                EditButton()
            )
            
        }
    }
}

struct checkin: Identifiable {
    var id = UUID()
    var name: String
    var item: String
    var time: String
    
}

let checkinList = [
    checkin(name: "Kim Burt", item: "2", time: "time"),
    checkin(name: "Jonathan", item: "1", time: "time"),
]

/*struct CheckinRow : View{
    var id = UUID()
    var name = "John Doe"
    var item = 1
    var time = "time time"
    var body: some View{
        return HStack(){
            Text(id)
            Text(name)
            Text(item)
            Text(time)
        }
    }
}*/

/*struct OneCheckin : Identifiable {
    var id = UUID()
    var name :String
    var item :Int16
    var time: String
}

var checkinList = [
    OneCheckin(name: "Kim Burt", item: 1, time:"02:00 am 21 Feb 2022"),
    OneCheckin(name: "Jonathen Ryes", item: 2, time: "time..")
]*/

struct CheckinList_Previews: PreviewProvider {
    static var previews: some View {
        CheckinList()
    }
}

