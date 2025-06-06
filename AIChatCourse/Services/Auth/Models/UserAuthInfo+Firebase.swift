//
//  UserAuthInfo+Firebase.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 11/05/2025.
//

import FirebaseAuth

extension UserAuthInfo {
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
    
}
