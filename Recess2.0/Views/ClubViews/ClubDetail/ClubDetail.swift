//
//  ClubDetail.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ClubDetail: View {
    @EnvironmentObject var dM: DataManager
    @Binding var club: Club
    @State var creator = User(id: "temp", name: "temp", city: "temp")
    @State var members = Array<User>()
    
    var body: some View {
        VStack {
            DetailHeader(title: club.getName(),
                         footer: club.getDescription(),
                         note: "Creator: \(creator.getName())",
                         truestring: "Private Club",
                         falsestring: "Public Club",
                         ifBool: club.getPrivateClub())
            .padding()
            if club.getPreReqsNeeded() {
                Text("Pre-Reqs")
                Text("Tier: \(club.getReqTier())").padding()
            } else {
                Text("No pre-reqs needed").padding()
            }
            Text("Members: \(members.count)")
            ForEach(members, id:\.self) { member in
                Text(member.getName())
            }
            Spacer()
            if creator.getID() != dM.currentUser.getID() {
                JoinClubButton(club: $club, members: $members)
            }
        }
        .padding()
        .onAppear {
            let clubRef = Firestore.firestore().collection("Clubs")
            clubRef.document(club.getID()).addSnapshotListener { documentSnapshot, error in
                do {
                    club = try documentSnapshot!.data(as: Club.self)
                } catch {
                    print(error)
                }
            }
            Task {
                creator = await club.getCreator()
                members = await club.getMembers()
            }
        }
    }
}

struct ClubDetail_Previews: PreviewProvider {
    static var previews: some View {
        ClubDetail(club: .constant(DataManager().clubs[0]),
                   creator: DataManager().currentUser).environmentObject(DataManager())
    }
}
