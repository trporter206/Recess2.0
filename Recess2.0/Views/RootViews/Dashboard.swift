//
//  Dashboard.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var dM: DataManager
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, \(dM.currentUser.getName())").padding()
                Text("Your scheduled activities (\(dM.currentUser.getScheduledMeetUps().count))").padding([.top])
                NavigationLink(destination: CreateMeetUpForm(), label: {
                    Text("Create Activity").padding([.bottom])
                })
                ForEach(dM.sortMeetUpsByDate(meetUps: dM.currentUser.getScheduledMeetUps()), id: \.self) { meetup in
                    MeetUpListItem(meetUp: binding(for: meetup))
                }
            }
        }
        .environmentObject(dM)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard().environmentObject(DataManager())
    }
}

extension Dashboard {
    func binding(for meetup: MeetUp) -> Binding<MeetUp> {
        guard let index = dM.meetUps.firstIndex(of: meetup) else {
            fatalError("Meetup not found")
        }
        return $dM.meetUps[index]
    }
}
