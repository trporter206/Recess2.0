//
//  Dashboard.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var dM: DataManager
    @State var joinedClubs = Array<Club>()
    @State var scheduledMeetUps = Array<MeetUp>()
    
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
                    NavigationLink(destination: CreateMeetUpForm(), label: {
                        Text("Create Activity").padding([.bottom])
                    })
                    Text("Your scheduled activities (\(dM.currentUser.getNumMeetUps()))").padding([.top])
                    ForEach($scheduledMeetUps) { $meetup in
                        MeetUpListItem(meetUp: $meetup)
                    }
                    Text("Your Joined Clubs (\(dM.currentUser.getNumJoinedClubs()))")
                    ForEach(joinedClubs) { club in
                        ClubListItem(club: binding(for: club))
                    }
                }
            }
        }
        .environmentObject(dM)
        .onAppear {
            Task {
                joinedClubs = await dM.currentUser.getJoinedClubs()
                scheduledMeetUps = await dM.currentUser.getScheduledMeetUps()
            }
        }
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
