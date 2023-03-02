//
//  ClubFields.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-03-01.
//

import SwiftUI

struct ClubFields: View {
    @Binding var newClubData: Club.Data
    
    var body: some View {
        TextField("Club Name", text: $newClubData.name).padding()
        TextField("Club Description", text: $newClubData.description).padding()
        Toggle("Pre-reqs needed to join", isOn: $newClubData.preReqsNeeded).toggleStyle(.switch).padding()
        if newClubData.preReqsNeeded {
            Stepper(value: $newClubData.reqWins, in: 0...100, step: 1) {
                HStack {
                    Text("Wins:")
                    TextField("Quantity", value: $newClubData.reqWins, formatter: NumberFormatter())
                        .keyboardType(.numbersAndPunctuation)
                }
            }.padding(.bottom)
            Stepper(value: $newClubData.reqTier, in: 0...3, step: 1) {
                HStack {
                    Text("Tier:")
                    TextField("Quantity", value: $newClubData.reqTier, formatter: NumberFormatter())
                        .keyboardType(.numbersAndPunctuation)
                }
            }.padding(.bottom)
            Stepper(value: $newClubData.reqHosted, in: 0...100, step: 1) {
                HStack {
                    Text("Hosted:")
                    TextField("Quantity", value: $newClubData.reqHosted, formatter: NumberFormatter())
                        .keyboardType(.numbersAndPunctuation)
                }
            }.padding(.bottom)
            Stepper(value: $newClubData.reqJoined, in: 0...100, step: 1) {
                HStack {
                    Text("Joined:")
                    TextField("Quantity", value: $newClubData.reqJoined, formatter: NumberFormatter())
                        .keyboardType(.numbersAndPunctuation)
                }
            }.padding(.bottom)
        }
    }
}

struct ClubFields_Previews: PreviewProvider {
    static var previews: some View {
        ClubFields(newClubData: .constant(Club.Data(id: UUID().uuidString)))
    }
}
