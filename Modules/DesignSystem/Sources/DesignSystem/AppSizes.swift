//
//  AppSizes.swift
//  DesignSystem
//
//  Created by Kamaal M Farah on 1/15/25.
//

import SwiftUI

/// Set app sizes.
public enum AppSizes: CGFloat {
    /// Size of 0
    case nada = 0
    /// Size of 2
    case extraExtraSmall = 2
    /// Size of 4
    case extraSmall = 4
    /// Size of 8
    case small = 8
    /// Size of 16
    case medium = 16
    /// Size of 24
    case large = 24
    /// Size of 32
    case extraLarge = 32
}

extension View {
    /// Set padding to the view with set ``AppSizes``.
    /// - Parameters:
    ///   - edges: Which edge or edges to set the padding to.
    ///   - length: The length of padding to set the view edge to.
    /// - Returns: The view with updated padding.
    public func padding(_ edges: Edge.Set = .all, _ length: AppSizes) -> some View {
        padding(edges, length.rawValue)
    }

    /// Set corner radius to the view with set ``AppSizes``.
    /// - Parameter length: The length of corner radius to set on the view.
    /// - Returns: The view with updated corner radius.
    public func cornerRadius(_ length: AppSizes) -> some View {
        cornerRadius(length.rawValue)
    }
}
