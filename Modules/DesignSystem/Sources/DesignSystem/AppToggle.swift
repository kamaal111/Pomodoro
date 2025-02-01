//
//  AppToggle.swift
//  DesignSystem
//
//  Created by Kamaal M Farah on 2/1/25.
//

import SwiftUI

public struct AppToggle: View {
    @Binding var isOn: Bool

    let title: String

    public init(_ title: String, isOn: Binding<Bool>) {
        self._isOn = isOn
        self.title = title
    }

    public var body: some View {
        Toggle(title, isOn: $isOn)
            .strikethrough(isOn)
    }
}

public struct AppToggleWithChangeHandler: View {
    @State private var isOn: Bool

    let title: String
    let onChange: (_ isOn: Bool) -> Void

    public init(_ title: String, wrappedValue: Bool, onChange: @escaping (_ isOn: Bool) -> Void) {
        self.title = title
        self._isOn = .init(wrappedValue: wrappedValue)
        self.onChange = onChange
    }

    public var body: some View {
        AppToggle(title, isOn: $isOn)
            .onChange(of: isOn) { oldValue, newValue in onChange(newValue) }
    }
}

#Preview {
    AppToggleWithChangeHandler("Toggle", wrappedValue: true, onChange: { _ in })
}
