//
//  Message.swift
//  RxPlayground
//
//  Created by Jack Beoris on 1/30/19.
//  Copyright © 2019 Jack Beoris. All rights reserved.
//

import Foundation
import RxDataSources

struct Message {
    let date: Date
    let number: Int
}

extension Message:
    Equatable,
    IdentifiableType {
    typealias Identity = Int
    
    var identity: Int {
        return number
    }
}

func == (lhs: Message, rhs: Message) -> Bool {
    return lhs.number == rhs.number && lhs.date == rhs.date
}
