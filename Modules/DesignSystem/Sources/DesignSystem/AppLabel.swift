//
//  AppLabel.swift
//  DesignSystem
//
//  Created by Kamaal M Farah on 1/15/25.
//

import SwiftUI

public enum AppLabelVariants {
    case simple
    case action
}

public struct AppLabel<Content: View>: View {
    public let variant: AppLabelVariants
    public let content: () -> Content

    public init(variant: AppLabelVariants = .simple, @ViewBuilder content: @escaping () -> Content) {
        self.variant = variant
        self.content = content
    }

    public var body: some View {
        JustStack {
            switch variant {
            case .simple:
                content()
            case .action:
                content()
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}

#Preview {
    AppLabel {
        Text("Hello")
    }
}
