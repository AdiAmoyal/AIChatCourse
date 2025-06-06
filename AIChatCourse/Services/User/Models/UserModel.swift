//
//  UserModel.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 07/05/2025.
//

import Foundation
import SwiftUI

struct UserModel: Codable {
    let userId: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lasSignInDate: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lasSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lasSignInDate = lasSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(
            userId: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationDate: auth.creationDate,
            creationVersion: creationVersion,
            lasSignInDate: auth.lastSignInDate
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lasSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
    }
    
    var profileColorCalculated: Color {
        guard let profileColorHex else { return .accent }
        return Color(hex: profileColorHex)
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        let now = Date()
        return [
            UserModel(
                userId: "user1",
                creationDate: now,
                didCompleteOnboarding: true,
                profileColorHex: "#33A1FF"
            ),
            UserModel(
                userId: "user2",
                creationDate: now.addingTimeInterval(days: -1),
                didCompleteOnboarding: false,
                profileColorHex: "#FF5733"
            ),
            UserModel(
                userId: "user3",
                creationDate: now.addingTimeInterval(days: -3, hours: -2),
                didCompleteOnboarding: true,
                profileColorHex: "#7DFF33"
            ),
            UserModel(
                userId: "user4",
                creationDate: now.addingTimeInterval(days: -5, hours: -4),
                didCompleteOnboarding: nil,
                profileColorHex: "#FF33A1"
            )
        ]
    }
}
