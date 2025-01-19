//
//  View+extensions.swift
//  DesignSystem
//
//  Created by Kamaal M Farah on 1/19/25.
//

import SwiftUI

extension View {
    public func takeSizeEagerly(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }

    public func takeWidthEagerly(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
}
