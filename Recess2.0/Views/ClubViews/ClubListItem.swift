//
//  ClubListItem.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-18.
//

import SwiftUI

struct ClubListItem: View {
    @EnvironmentObject var dM: DataManager
    @Binding var club: Club
    
    var body: some View {
        NavigationLink(destination: ClubDetail(club: $club), label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                    .shadow(radius: 2.5, x: 3, y: 4)
                    .padding()
                VStack (alignment: .leading) {
                    Text(club.getName())
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding([.top])
                    Text("Members: \(club.getMembers().count)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding([.bottom])
                }
                .padding()
            }
        })
    }
}

struct ClubListItem_Previews: PreviewProvider {
    static var previews: some View {
        ClubListItem(club: .constant(DataManager().clubs[0])).environmentObject(DataManager())
    }
}
