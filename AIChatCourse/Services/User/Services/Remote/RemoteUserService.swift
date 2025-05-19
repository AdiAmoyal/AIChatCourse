//
//  RemoteUserService.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 19/05/2025.
//


protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func makeOnboardingCompleted(userId: String, profileColorHex: String) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, any Error>
    func deleteUser(userId: String) async throws
}