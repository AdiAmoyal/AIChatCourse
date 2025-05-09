//
//  ChatBubbleViewBuilder.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 08/05/2025.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {
    
    var message: ChatMessageModel = .mock
    var isCurrentUser: Bool = false
    var imageName: String?
    var onImagePressed: (() -> Void)?
    
    var body: some View {
        ZStack {
            ChatBubbleView(
                text: message.content ?? "",
                textColor: isCurrentUser ? .white : .primary,
                backgroundColor: isCurrentUser ? .accent : Color(uiColor: .systemGray6),
                showImage: !isCurrentUser,
                imageName: imageName,
                onImagePressed: onImagePressed
            )
            .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
            .padding(.leading, isCurrentUser ? 75 : 0)
            .padding(.trailing, isCurrentUser ? 0 : 75)
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 24) {
            ChatBubbleViewBuilder()
            
            ChatBubbleViewBuilder(isCurrentUser: true)
            
            ChatBubbleViewBuilder()
        }
        .padding()
    }
}
