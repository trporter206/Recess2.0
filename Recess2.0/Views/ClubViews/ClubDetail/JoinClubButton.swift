//
//  JoinClubButton.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI

struct JoinClubButton: View {
    @EnvironmentObject var dM: DataManager
    @Binding var club: Club
    var body: some View {
        if club.getCreator().getName() != dM.currentUser.getName() {
            if club.getMembers().contains(where: {$0.getID() == dM.currentUser.getID()}) {
                Button(action: {
                    do {
                        try club.removeMember(user: dM.currentUser)
                        try dM.currentUser.leaveClub(club: club)
                    } catch {
                        print(error)
                    }
                }, label: {
                    Text("Leave Club")
                })
            } else {
                Button(action: {
                    do {
                        try club.addMember(user: dM.currentUser)
                    } catch {
                        print(error)
                    }
                    dM.currentUser.joinClub(club: club)
                }, label: {
                    Text("Join Club")
                })
            }
        }
    }
}

struct JoinClubButton_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubButton(club: .constant(DataManager().clubs[0])).environmentObject(DataManager())
    }
}
