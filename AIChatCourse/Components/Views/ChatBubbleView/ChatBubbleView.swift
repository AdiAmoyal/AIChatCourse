//
//  ChatBubbleView.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 08/05/2025.
//

import SwiftUI

struct ChatBubbleView: View {
    
    var text: String = "This is samle text"
    var textColor: Color = .primary
    var backgroundColor: Color = Color(uiColor: .systemGray6)
    var showImage: Bool = true
    var imageName: String?
    
    let offset: CGFloat = 10
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if showImage {
                ZStack {
                    if let imageName {
                        ImageLoaderView(urlString: imageName)
                    } else {
                        Rectangle()
                            .fill(.secondary)
                    }
                }
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .offset(y: offset)
            }
            
            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .cornerRadius(10)
        }
        .padding(.bottom, showImage ? offset : 0)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ChatBubbleView()
            
            ChatBubbleView(text: "This ia a very long text that wraps to multiple lines and it keeps going.")
            ChatBubbleView()
            
            ChatBubbleView(
                text: "This ia a very long text that wraps to multiple lines and it keeps going.",
                textColor: .white,
                backgroundColor: .accentColor,
                showImage: false,
                imageName: nil
            )
        }
        .padding()
    }
}
