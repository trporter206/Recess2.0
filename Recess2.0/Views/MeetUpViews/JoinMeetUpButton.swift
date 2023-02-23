//
//  JoinMeetUpButton.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI

struct JoinMeetUpButton: View {
    @EnvironmentObject var dM: DataManager
    @Binding var meetUp: MeetUp
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if meetUp.getHost().getID() != dM.currentUser.getID() {
            if meetUp.getPlayers().contains(where: {$0.getID() == dM.currentUser.getID()}) {
                Button(action: {
                    do {
                        try dM.currentUser.removeMeetUp(mu: meetUp)
                        try meetUp.removePlayer(user: dM.currentUser)
                    } catch {
                        print(error)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Leave Session")
                })
            } else {
                Button(action: {
                    dM.currentUser.addMeetUp(mu: meetUp)
                    meetUp.addPlayer(user: dM.currentUser)
                    dM.currentUser.addToMeetUpsJoined()
                }, label: {
                    Text("Join Session")
                })
            }
        }
    }
}

struct JoinMeetUpButton_Previews: PreviewProvider {
    static var previews: some View {
        JoinMeetUpButton(meetUp: .constant(DataManager().meetUps[0]))
    }
}
