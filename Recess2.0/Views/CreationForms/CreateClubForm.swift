//
//  CreateClubForm.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI

struct CreateClubForm: View {
    @EnvironmentObject var dM: DataManager
    @State private var newClubData = Club.Data()
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Create club form")
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
            Toggle("Club is private", isOn: $newClubData.privateClub).toggleStyle(.switch).padding()
            Button(action: {
                let c = Club(creator: dM.currentUser,
                             name: newClubData.name,
                             description: newClubData.description,
                             privateClub: newClubData.privateClub,
                             preReqsNeeded: newClubData.preReqsNeeded,
                             reqHosted: newClubData.reqHosted,
                             reqJoined: newClubData.reqJoined,
                             reqTier: newClubData.reqTier,
                             reqWins: newClubData.reqWins)
                dM.clubs.append(c)
                showingAlert = true
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Create club")
            })
            .alert("Club Created", isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
        }
        .padding()
    }
}

struct CreateClubForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateClubForm().environmentObject(DataManager())
    }
}
