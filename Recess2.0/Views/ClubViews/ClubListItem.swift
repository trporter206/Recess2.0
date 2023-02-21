//
//  ClubListItem.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-18.
//

import SwiftUI

struct ClubListItem: View {
    @EnvironmentObject var dataManager: DataManager
    @Binding var club: Club
    
    var body: some View {
        NavigationLink(destination: ClubDetail(club: $club), label: {
            VStack (alignment: .leading) {
                Text(club.getName())
                    .font(.title3)
                    .foregroundColor(.black)
                Text("Members: \(club.getMembers().count)")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding()
        })
        .padding()
        .border(.black, width: 2)
    }
}

struct ClubListItem_Previews: PreviewProvider {
    static var previews: some View {
        ClubListItem(club: .constant(DataManager().clubs[0])).environmentObject(DataManager())
    }
}
