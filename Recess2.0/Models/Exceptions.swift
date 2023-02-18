//
//  Exceptions.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-17.
//

import Foundation

enum RecessExceptions: Error {
    case userNotFound
    case userNotInClub
    case clubNotFound
    case clubNotRequested
    case clubAlreadyRequested
    case meetUpNotFound
}

extension RecessExceptions: CustomStringConvertible {
    public var description: String {
        switch self {
        case .userNotFound:
            return "User not found"
        case .userNotInClub:
            return "User is not in club"
        case .clubNotRequested:
            return "Club not found in requests"
        case .clubAlreadyRequested:
            return "Club has already been requested"
        case .clubNotFound:
            return "Club not in current clubs"
        case .meetUpNotFound:
            return "Meet up not found"
        }
    }
}
