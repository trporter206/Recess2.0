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
            Text(dM.currentUser.getName())
            Text(dM.currentUser.getCity())
            Text("About: \(dM.currentUser.getAbout())")
            Text("Clubs joined: \(dM.currentUser.getJoinedClubs().count)")
            Text("Clubs requested: \(dM.currentUser.getRequestedClubs().count)")
            Text("# Activities hosted: \(dM.currentUser.getNumHostedMeets())")
            Text("# Activities joined: \(dM.currentUser.getNumJoinedMeets())")
            Text("# Activities scheduled: \(dM.currentUser.getScheduledMeetUps().count)")
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile().environmentObject(DataManager())
    }
}
