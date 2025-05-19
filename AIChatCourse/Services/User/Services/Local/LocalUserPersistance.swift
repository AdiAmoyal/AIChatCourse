//
//  LocalUserPersistance.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 19/05/2025.
//


protocol LocalUserPersistance {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}