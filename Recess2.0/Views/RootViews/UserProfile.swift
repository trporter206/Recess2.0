//
//  UserProfile.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-20.
//

import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var dM: DataManager
    var body: some View {
        VStack {
            DetailHeader(title: dM.currentUser.getName(),
                         footer: dM.currentUser.getAbout(),
                         note: "Clubs joined: \(dM.currentUser.getJoinedClubs().count)",
                         truestring: "Activities hosted: \(dM.currentUser.getNumHostedMeets())",
                         falsestring: "",
                         ifBool: true)
            Text(dM.currentUser.getCity())
            Text("# Activities joined: \(dM.currentUser.getNumJoinedMeets())")
            Text("# Activities scheduled: \(dM.currentUser.getScheduledMeetUps().count)")
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile().environmentObject(DataManager())
    }
}
