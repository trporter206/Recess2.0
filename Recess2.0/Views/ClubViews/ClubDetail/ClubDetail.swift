//
//  ClubDetail.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI

struct ClubDetail: View {
    @EnvironmentObject var dM: DataManager
    @Binding var club: Club
    
    var body: some View {
        VStack {
            DetailHeader(title: club.getName(),
                         footer: club.getDescription(),
                         note: "Creator: \(club.getCreator().getName())",
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
            Text("Members: \(club.getMembers().count)")
            ForEach(club.getMembers(), id:\.self) { member in
                Text(member.getName())
            }
            Spacer()
            JoinClubButton(club: $club)
        }
        .padding()
    }
}

struct ClubDetail_Previews: PreviewProvider {
    static var previews: some View {
        ClubDetail(club: .constant(DataManager().clubs[0])).environmentObject(DataManager())
    }
}
