//
//  DetailHeader.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI

struct DetailHeader: View {
    @EnvironmentObject var dm: DataManager
    var title: String
    var footer: String
    var note: String
    var truestring: String
    var falsestring: String
    var ifBool: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
            Text(footer)
                .font(.subheadline)
            HStack {
                Text(note)
                Spacer()
                if ifBool {
                    Text(truestring)
                } else {
                    Text(falsestring)
                }
            }
            .padding()
            Divider().padding([.leading, .trailing])
        }
    }
}

struct DetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeader(title: "String 1", footer: "String 2", note: "String 3", truestring: "String 4", falsestring: "String 5", ifBool: true)
    }
}
