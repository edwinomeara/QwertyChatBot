//
//  ChatMessageCell.swift
//  ChatApp
//
//  Created by Edwin  O'Meara on 1/10/19.
//  Copyright © 2019 Edwin  O'Meara. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    //is each label
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .darkGray
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }else{
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }
    
    func configureCell() {
        backgroundColor = .clear
        
        //bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.layer.cornerRadius = 10
        addSubview(bubbleBackgroundView)
        
        addSubview(messageLabel)
        //messageLabel.backgroundColor = .blue
        messageLabel.text = "SOME MESSAGE iojh89iehidhfkdnxcjeiojiejifjiejijij efijijijifemkmfekmkefmkemfkemfkemfk fewejfojweofjelkofkeokfoekfok"
        messageLabel.numberOfLines = 0
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints for label
        let constraints =
            [
                messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(16)),
                
                messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat(-16)),
                // messageLabel.widthAnchor.constraint(equalToConstant: 250),
                messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: CGFloat(250)),
                
                bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: CGFloat(-8)),
                bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: CGFloat(-8)),
                bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: CGFloat(8)),
                bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(16))
        
        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        
        trailingConstraint.isActive = true
    }
    
}
