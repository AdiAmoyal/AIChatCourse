//
//  MockUserPersistance.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 19/05/2025.
//


struct MockUserPersistance: LocalUserPersistance {
    
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        
    }
}