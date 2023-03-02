//
//  JoinClubButton.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct JoinClubButton: View {
    @EnvironmentObject var dM: DataManager
    @Binding var club: Club
    @Binding var members: Array<User>
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if members.contains(where: {$0.getID() == dM.currentUser.getID()}) {
                Button(action: {
                    do {
                        try club.removeMember(userID: dM.currentUser.getID())
                        try dM.currentUser.leaveClub(club: club)
                    } catch {
                        print(error)
                    }
                    members.removeAll(where: {$0.getID() == dM.currentUser.getID()})
                    self.presentationMode.wrappedValue.dismiss()
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
                    members.append(dM.currentUser)
                }, label: {
                    Text("Join Club")
                })
            }
        }
    }
}

struct JoinClubButton_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubButton(club: .constant(DataManager().clubs[0]),
                       members: .constant([])).environmentObject(DataManager())
    }
}
