//
//  JoinClubButton.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct JoinClubButton: View {
    @EnvironmentObject var dataManager: DataManager
    @Binding var club: Club
    var body: some View {
        if club.getCreator().getName() != dataManager.currentUser.getName() {
            if club.getRequests().contains(where: {$0.getID() == dataManager.currentUser.getID()}) {
                Text("Club Request Pending")
            } else if club.getMembers().contains(where: {$0.getID() == dataManager.currentUser.getID()}) {
                Button(action: {
                    do {
                        try club.removeMember(user: dataManager.currentUser)
                    } catch {
                        print(error)
                    }
                }, label: {
                    Text("Leave Club")
                })
            } else {
                if !club.getPrivateClub() {
                    Button(action: {
                        do {
                            try club.addMember(user: dataManager.currentUser, accepted: true)
                        } catch {
                            print(error)
                        }
                    }, label: {
                        Text("Join Club")
                    })
                } else {
                    Button(action: {
                        do {
                            try dataManager.currentUser.addClubRequest(club: club)
                        } catch {
                            print(error)
                        }
                        club.newRequest(user: dataManager.currentUser)
                    }, label: {
                        Text("Request to Join Club")
                    })
                }
            }
        }
    }
}

struct JoinClubButton_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubButton(club: .constant(DataManager().clubs[0])).environmentObject(DataManager())
    }
}
