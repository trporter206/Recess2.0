//
//  UserProfile.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-20.
//

import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var dM: DataManager
    @State var joinedClubs = Array<Club>()
    @State var createdClubs = Array<Club>()
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    DetailHeader(title: dM.currentUser.getName(),
                                 footer: dM.currentUser.getAbout(),
                                 note: "Clubs joined: \(joinedClubs.count)",
                                 truestring: "Activities hosted: \(dM.currentUser.getNumHostedMeets())",
                                 falsestring: "",
                                 ifBool: true)
                    Text(dM.currentUser.getCity())
                    Text("Your created clubs:")
                    ForEach($createdClubs) { $club in
                        ClubListItem(club: $club)
                    }
                    Text("# Activities joined: \(dM.currentUser.getNumJoinedMeets())")
                    Text("# Activities scheduled: \(dM.currentUser.getScheduledMeetUps().count)")
                    Spacer()
                }
            }
        }
        .onAppear {
            Task {
                createdClubs = await dM.currentUser.getCreatedClubs()
                joinedClubs = await dM.currentUser.getJoinedClubs()
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile().environmentObject(DataManager())
    }
}
