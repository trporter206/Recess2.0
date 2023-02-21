//
//  MeetUpList.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-20.
//

import SwiftUI

struct MeetUpList: View {
    @EnvironmentObject var dM: DataManager
    
    var body: some View {
        VStack {
            NavigationLink(destination: CreateMeetUpForm(), label: {
                Text("Create Activity").padding()
            })
            Text("Number of Activities: \(dM.meetUps.count)").bold().padding()
            ForEach($dM.meetUps, id: \.self) { $meetup in
                MeetUpListItem(meetUp: $meetup)
            }
        }
    }
}

struct MeetUpList_Previews: PreviewProvider {
    static var previews: some View {
        MeetUpList().environmentObject(DataManager())
    }
}
