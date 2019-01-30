//
//  MessageViewController.swift
//  RxPlayground
//
//  Created by Jack Beoris on 1/30/19.
//  Copyright © 2019 Jack Beoris. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class MessageViewController: UIViewController {
    
    enum Constants {
        static let header: String = "Section 0"
        static let timerInterval: TimeInterval = 2.0
    }
    
    lazy var messageTableView: MessageTableView = {
        let messageTableView = MessageTableView()
        
        messageTableView.register(
            MessageTableViewCell.self,
            forCellReuseIdentifier: MessageTableViewCell.Identifier
        )
        messageTableView.allowsSelection = false
        messageTableView.estimatedRowHeight = 140.0
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.keyboardDismissMode = .interactive
        messageTableView.separatorStyle = .none
        
        return messageTableView
    }()
    
    let messages: Variable<[Message]> = Variable([])
    var messageSection: MessageSection = MessageSection(header: Constants.header, messages: [], updated: Date())
    let disposeBag: DisposeBag = DisposeBag()
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDataSource()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }

}

extension MessageViewController {
    
    func setupViews() {
        view.addSubview(messageTableView)
        messageTableView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    func setDataSource() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<MessageSection>(
            animationConfiguration: AnimationConfiguration(
                insertAnimation: .bottom,
                reloadAnimation: .none,
                deleteAnimation: .left
            ),
            configureCell: { (dataSource, tableView, indexPath, message) -> UITableViewCell in
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: MessageTableViewCell.Identifier,
                        for: indexPath
                    ) as? MessageTableViewCell
                else {
                    return UITableViewCell()
                }
                
                cell.configure(with: message)
                
                return cell
            }
        )
        
        messages
            .asObservable()
            .map({ [weak self] messages -> [MessageSection] in
                guard let `self` = self else { return [] }
                
                let messageSection = MessageSection(original: self.messageSection, items: messages)
                self.messageSection = messageSection
                
                return [messageSection]
            })
            .bind(to: messageTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(
            timeInterval: Constants.timerInterval,
            target: self,
            selector: #selector(appendMessage),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func appendMessage() {
        messages
            .value
            .append(
                Message(
                    date: Date(),
                    number: messages.value.count + 1
                )
            )
    }
    
}
