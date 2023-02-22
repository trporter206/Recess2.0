//
//  ClubDetail.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI

struct ClubDetail: View {
    @EnvironmentObject var dM: DataManager
    @Binding var club: Club
    
    var body: some View {
        VStack {
            Group {
                Text(club.getName())
                    .font(.title)
                Text(club.getDescription()).font(.subheadline)
                    .padding([.bottom])
                HStack {
                    Text("Creator: \(club.getCreator().getName())")
                    Spacer()
                    if club.getPrivateClub() {
                        Text("Private Club")
                    } else {
                        Text("Public Club")
                    }
                }
                Divider()
                .padding()
                if club.getPreReqsNeeded() {
                    Text("Pre-requirements needed")
                    Text("Wins: \(club.getReqWins())")
                    Text("Hosted: \(club.getReqHosted())")
                    Text("Joined: \(club.getReqJoined())")
                    Text("Tier: \(club.getReqTier())")
                } else {
                    Text("No pre-reqs needed").padding()
                }
                Text("Scheduled Meets: \(club.getScheduledGames().count)").padding([.top])
                ForEach(club.getScheduledGames(), id:\.self) { meet in
                    Text(meet.getSport())
                }
                Text("Members: \(club.getMembers().count)").padding([.top])
                ForEach(club.getMembers(), id:\.self) { member in
                    Text(member.getName())
                }
                Spacer()
            }
            JoinClubButton(club: $club)
        }
        .padding()
    }
}

struct ClubDetail_Previews: PreviewProvider {
    static var previews: some View {
        ClubDetail(club: .constant(DataManager().clubs[2])).environmentObject(DataManager())
    }
}

