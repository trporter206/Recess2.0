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
            Text(club.getName())
                .font(.title)
            Text(club.getDescription()).font(.subheadline)
            HStack {
                Text("Creator: \(club.getCreator().getName())")
                Spacer()
                if club.getPrivateClub() {
                    Text("Private Club")
                } else {
                    Text("Public Club")
                }
            }
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
