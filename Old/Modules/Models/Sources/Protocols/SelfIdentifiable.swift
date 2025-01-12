//
//  SelfIdentifiable.swift
//  
//
//  Created by Kamaal Farah on 11/06/2023.
//

import Foundation

public protocol SelfIdentifiable: Identifiable { }

extension SelfIdentifiable {
    public var id: Self { self }
}
