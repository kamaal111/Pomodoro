//
//  AppButton.swift
//  DesignSystem
//
//  Created by Kamaal M Farah on 1/15/25.
//

import SwiftUI

public enum AppButtonVariants {
    case simple
    case plain
}

public struct AppButton<Label: View>: View {
    public let variant: AppButtonVariants
    public let label: () -> Label
    public let action: () -> Void

    public init(
        variant: AppButtonVariants = .simple,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.variant = variant
        self.label = label
        self.action = action
    }

    public var body: some View {
        JustStack {
            switch variant {
            case .simple:
                Button(action: action) {
                    AppLabel {
                        label()
                    }
                }
            case .plain:
                Button(action: action) {
                    AppLabel(variant: .action) {
                        label()
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    AppButton(action: { }) {
        Text("Hello")
    }
}
