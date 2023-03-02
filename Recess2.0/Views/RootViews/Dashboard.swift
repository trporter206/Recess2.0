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
            ScrollView(.vertical) {
                VStack {
                    HStack {
                        VStack (alignment: .leading){
                            Text("\(dM.currentUser.getName()),")
                            Text("Good Morning")
                                .font(.title)
                                .padding([.bottom])
                        }.padding([.leading])
                        Spacer()
                    }
                    Divider().padding([.leading, .trailing])
                    Text("Your scheduled activities (\(dM.currentUser.getScheduledMeetUps().count))").padding([.top])
                    NavigationLink(destination: CreateMeetUpForm(), label: {
                        Text("Create Activity").padding([.bottom])
                    })
                    ForEach(dM.currentUser.getScheduledMeetUps()) { meetup in
                        MeetUpListItem(meetUp: binding(for: meetup))
                    }
                    Text("Your Clubs (\(dM.currentUser.getJoinedClubs().count))")
                    ForEach(dM.currentUser.getJoinedClubs()) { club in
                        ClubListItem(club: binding(for: club))
                    }
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
    
    func binding(for club: Club) -> Binding<Club> {
        guard let index = dM.clubs.firstIndex(of: club) else {
            fatalError("Club not found")
        }
        return $dM.clubs[index]
    }
}
