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
    @Binding var players: Array<User>
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if players.contains(where: {$0.getID() == dM.currentUser.getID()}) {
            Button(action: {
                do {
                    try dM.currentUser.removeMeetUp(muID: meetUp.getID())
                    try meetUp.removePlayer(userID: dM.currentUser.getID())
                } catch {
                    print(error)
                }
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Leave Session")
            })
        } else {
            Button(action: {
                dM.currentUser.addMeetUp(muID: meetUp.getID())
                meetUp.addPlayer(user: dM.currentUser)
                dM.currentUser.addToMeetUpsJoined()
                players.append(dM.currentUser)
            }, label: {
                Text("Join Session")
            })
        }
    }
}

struct JoinMeetUpButton_Previews: PreviewProvider {
    static var previews: some View {
        JoinMeetUpButton(meetUp: .constant(DataManager().meetUps[0]), players: .constant([]))
    }
}
