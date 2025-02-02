//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Kamaal M Farah on 2/2/25.
//

import SwiftUI

extension View {
    public func deletable<Item: Equatable>(
        deletingItem: Binding<Item?>,
        item: Item,
        isEnabled: Bool,
        deleteText: String,
        onDelete: @escaping (_ item: Item) -> Void
    ) -> some View {
        DeletableView(
            deletingItem: deletingItem,
            item: item,
            isEnabled: isEnabled,
            deleteText: deleteText,
            onDelete: onDelete,
            content: { self }
        )
    }
}

public struct DeletableView<Content: View, Item: Equatable>: View {
    @State private var textSize = CGSize(width: 60, height: 60)

    @Binding private var deletingItem: Item?

    @ViewBuilder let content: () -> Content

    let item: Item
    let isEnabled: Bool
    let deleteText: String
    let onDelete: (_ item: Item) -> Void

    public init(
        deletingItem: Binding<Item?>,
        item: Item,
        isEnabled: Bool,
        deleteText: String,
        onDelete: @escaping (_ item: Item) -> Void,
        content: @escaping () -> Content
    ) {
        self._deletingItem = deletingItem
        self.item = item
        self.isEnabled = isEnabled
        self.content = content
        self.onDelete = onDelete
        self.deleteText = deleteText
    }

    public var body: some View {
        HStack {
            if isEnabled, !isDeleting {
                AppButton(variant: .plain, action: { withAnimation { deletingItem = item } }) {
                    AppLabel(variant: .simple) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                            .padding(.leading, .medium)
                    }
                }
            }
            content()
            if isEnabled, isDeleting {
                Spacer()
                AppButton(variant: .plain, action: _onDelete) {
                    AppLabel(variant: .simple) {
                        ZStack {
                            Color.red
                            Text(deleteText)
                                .foregroundColor(light: .white, dark: .black)
                                .bindToFrameSize($textSize)
                        }
                        .frame(
                            minWidth: deleteButtonWidth,
                            maxWidth: deleteButtonWidth,
                            minHeight: deleteButtonHeight,
                            maxHeight: deleteButtonHeight
                        )
                    }
                }
            }
        }
        .takeWidthEagerly(alignment: .leading)
    }

    private var deleteButtonWidth: CGFloat {
        textSize.width + AppSizes.medium
    }

    private var deleteButtonHeight: CGFloat {
        textSize.height + AppSizes.medium
    }

    private var isDeleting: Bool {
        deletingItem == item
    }

    private func _onDelete() {
        onDelete(item)
        withAnimation {
            deletingItem = nil
        }
    }
}

#Preview {
    let item = 1

    DeletableView(deletingItem: .constant(nil), item: item, isEnabled: true, deleteText: "Delete", onDelete: { _ in }) {
        Text("I am deletable")
    }
    .padding(.horizontal, .medium)

    DeletableView(deletingItem: .constant(item), item: item, isEnabled: true, deleteText: "Delete", onDelete: { _ in }) {
        Text("I am deletable")
    }
    .padding(.horizontal, .medium)
}
