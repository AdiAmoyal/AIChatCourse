//
//  UserManager.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 13/05/2025.
//
import SwiftUI

@MainActor
@Observable
class UserManager {
    
    private let remote: RemoteUserService
    private let local: LocalUserPersistance
    
    private(set) var currentUser: UserModel?
    private var currentUserListener: ListenerRegistration?
    
    init(services: UserServices) {
        self.remote = services.remote
        self.local = services.local
        self.currentUser = local.getCurrentUser()
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        try await remote.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()
        
        Task {
            do {
                for try await value in remote.streamUser(userId: userId) {
                    self.currentUser = value
                    self.saveCurrentUsetLocally()
                    print("Successfully listened to user: \(value.userId)")
                }
            } catch {
                print("Error attaching user listener \(error)")
            }
        }
    }
    
    private func saveCurrentUsetLocally() {
        Task {
            do {
                try local.saveCurrentUser(user: currentUser)
                print("Success saved current user locally")
            } catch {
                print("Error saving current user locally: \(error)")
            }
        }
    }
    
    func markOnboardingCompleteForCuurrentUser(profileColorHex: String) async throws {
        let uid = try currentUserId()
        try await remote.makeOnboardingCompleted(userId: uid, profileColorHex: profileColorHex)
    }
    
    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await remote.deleteUser(userId: uid)
        signOut()
    }
    
    private func currentUserId() throws -> String {
        guard let uid = currentUser?.userId else {
            throw UserManagerError.noUserId
        }
        return uid
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
