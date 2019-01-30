//
//  MessageTableViewCell.swift
//  RxPlayground
//
//  Created by Jack Beoris on 1/30/19.
//  Copyright © 2019 Jack Beoris. All rights reserved.
//

import UIKit
import SnapKit

class MessageTableViewCell: UITableViewCell {
    
    static let Identifier: String = "MessageTableViewCell"
    
    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        messageLabel.textAlignment = .left
        messageLabel.textColor = .white
        return messageLabel
    }()
    
    lazy var messageView: UIView = {
        let messageView = UIView()
        messageView.backgroundColor = .blue
        messageView.layer.cornerRadius = 5.0
        messageView.clipsToBounds = true
        return messageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        messageLabel.text = ""
    }
    
    func setupViews() {
        addSubview(messageView)
        messageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5.0)
            make.right.bottom.equalToSuperview().offset(-5.0)
        }
        
        messageView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(20.0)
            make.left.top.equalToSuperview().offset(5.0)
            make.right.bottom.equalToSuperview().offset(-5.0)
        }
    }
    
    func configure(with message: Message) {
        messageLabel.text = "Message \(message.number): \(message.date.timeIntervalSince1970)"
    }
    
}
