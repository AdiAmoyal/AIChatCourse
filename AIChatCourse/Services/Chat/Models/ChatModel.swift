//
//  ChatModel.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 06/05/2025.
//

import Foundation

struct ChatModel: Identifiable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date
    
    init(id: String, userId: String, avatarId: String, dateCreated: Date, dateModified: Date) {
        self.id = id
        self.userId = userId
        self.avatarId = avatarId
        self.dateCreated = dateCreated
        self.dateModified = dateModified
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        let now = Date()
        return [
            ChatModel(id: "mock_chat_1", userId: "user1", avatarId: "avatar1", dateCreated: now, dateModified: now),
            ChatModel(id: "mock_chat_2", userId: "user2", avatarId: "avatar2", dateCreated: now.addingTimeInterval(hours: -1), dateModified: now.addingTimeInterval(minutes: -30)),
            ChatModel(id: "mock_chat_3", userId: "user3", avatarId: "avatar3", dateCreated: now.addingTimeInterval(hours: -2), dateModified: now.addingTimeInterval(hours: -1)),
            ChatModel(id: "mock_chat_4", userId: "user4", avatarId: "avatar4", dateCreated: now.addingTimeInterval(days: -1), dateModified: now.addingTimeInterval(hours: -10))
        ]
    }
}
