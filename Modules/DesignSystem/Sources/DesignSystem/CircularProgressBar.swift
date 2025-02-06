//
//  CircularProgressBar.swift
//  Features
//
//  Created by Kamaal M Farah on 2/6/25.
//

import SwiftUI

public struct CircularProgressBar: View {
    let progress: Double
    let lineWidth: CGFloat

    public init(progress: Double, lineWidth: CGFloat) {
        self.progress = progress
        self.lineWidth = lineWidth
    }

    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(.accentColor)
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(.accentColor)
                .rotationEffect(Angle(degrees: 270))
        }
    }
}

#Preview {
    CircularProgressBar(progress: 0.7, lineWidth: 30)
}
