//
//  MessageSection.swift
//  RxPlayground
//
//  Created by Jack Beoris on 1/30/19.
//  Copyright © 2019 Jack Beoris. All rights reserved.
//

import Foundation
import RxDataSources

struct MessageSection {
    var header: String
    var messages: [Message]
    var updated: Date
    
    init(header: String, messages: [Message], updated: Date) {
        self.header = header
        self.messages = messages
        self.updated = updated
    }
}

extension MessageSection:
    Equatable,
    AnimatableSectionModelType {
    typealias Item = Message
    typealias Identity = String
    
    var identity: String {
        return header
    }
    
    var items: [Message] {
        return messages
    }
    
    init(original: MessageSection, items: [Item]) {
        self = original
        self.messages = items
    }
}

func == (lhs: MessageSection, rhs: MessageSection) -> Bool {
    return lhs.header == rhs.header && lhs.items == rhs.items && lhs.updated == rhs.updated
}
