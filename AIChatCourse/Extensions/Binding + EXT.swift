//
//  Binding + EXT.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 08/05/2025.
//
import Foundation
import SwiftUI

extension Binding where Value == Bool {
    
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
