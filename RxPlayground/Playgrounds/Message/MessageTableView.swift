//
//  MessageTableView.swift
//  RxPlayground
//
//  Created by Jack Beoris on 1/30/19.
//  Copyright © 2019 Jack Beoris. All rights reserved.
//

import UIKit

class MessageTableView: UITableView {
    
    override func endUpdates() {
        super.endUpdates()
        
        scrollToBottom()
    }
    
    func scrollToBottom() {
        guard numberOfSections > 0 else { return }
        
        let lastRow = numberOfRows(inSection: 0) - 1
        
        guard lastRow >= 0 else { return }
        
        let indexPath = IndexPath(row: lastRow, section: 0)
        self.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
}
