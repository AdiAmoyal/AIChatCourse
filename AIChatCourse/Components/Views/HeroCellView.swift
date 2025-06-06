//
//  HeroCellView.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 06/05/2025.
//

import SwiftUI

struct HeroCellView: View {
    
    var title: String? = "This is some title"
    var subtitle: String? = "This is some subtitle that will go here"
    var imageName: String? = Constants.randonImage
    
    var body: some View {
        ZStack {
            if let imageName {
                ImageLoaderView(urlString: imageName)
            } else {
                Rectangle()
                    .fill(.accent)
            }
        }
        .overlay(
            alignment: .bottomLeading,
            content: {
                VStack(alignment: .leading, spacing: 8) {
                    if let title {
                        Text(title)
                            .font(.headline)
                    }
                    
                    if let subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                    }
                }
                .foregroundStyle(.white)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .addingGradientBackgroundForText()
        })
        .cornerRadius(16)
    }
}

#Preview {
    ScrollView {
        VStack {
            HeroCellView()
                .frame(width: 300, height: 200)
            
            HeroCellView()
                .frame(width: 300, height: 400)
            
            HeroCellView()
                .frame(width: 200, height: 400)
            
            HeroCellView(imageName: nil)
                .frame(width: 300, height: 200)
            
            HeroCellView(title: nil)
                .frame(width: 300, height: 200)
            
            HeroCellView(subtitle: nil)
                .frame(width: 300, height: 200)
        }
        .frame(maxWidth: .infinity)
    }
    
}
