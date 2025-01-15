//
//  JustStack.swift
//  DesignSystem
//
//  Created by Kamaal M Farah on 1/15/25.
//

import SwiftUI

public struct JustStack<Content: View>: View {
    public let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
    }
}

#Preview {
    JustStack {
        Text("Hell")
    }
}
