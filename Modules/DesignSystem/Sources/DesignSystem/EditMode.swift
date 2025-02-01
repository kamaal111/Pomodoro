//
//  EditMode.swift
//  DesignSystem
//
//  Created by Kamaal M Farah on 2/1/25.
//

import SwiftUI

#if os(macOS)
public enum EditMode: Sendable {
    case active
    case inactive

    public var isEditing: Bool {
        self == .active
    }

    var toggled: EditMode {
        if isEditing { .inactive } else { .active }
    }

    public mutating func toggle() {
        self = toggled
    }
}

public struct EditModeKey: EnvironmentKey {
    public static let defaultValue: Binding<EditMode>? = nil
}

extension EnvironmentValues {
    public var editMode: Binding<EditMode>? {
        get { self[EditModeKey.self] }
        set { self[EditModeKey.self] = newValue }
    }
}

public struct EditButton: View {
    @Environment(\.editMode) private var editMode

    public init() { }

    public var body: some View {
        AppButton(variant: .simple, action: handleAction) {
            AppLabel(variant: .action) {
                Text(label)
                    .bold()
            }
        }
    }

    private var label: String {
        guard let editMode else {
            assertionFailure("No environment set")
            return NSLocalizedString("Edit", comment: "")
        }

        if editMode.wrappedValue.isEditing {
            return NSLocalizedString("Done", comment: "")
        }

        return NSLocalizedString("Edit", comment: "")
    }

    private func handleAction() {
        guard editMode != nil else {
            assertionFailure("No environment set")
            return
        }

        withAnimation { self.editMode!.wrappedValue.toggle() }
    }
}
#endif
