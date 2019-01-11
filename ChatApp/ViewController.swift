//
//  ViewController.swift
//  ChatApp
//
//  Created by Edwin  O'Meara on 1/10/19.
//  Copyright © 2019 Edwin  O'Meara. All rights reserved.
//

import UIKit
import ApiAI
import AVFoundation


let keyBoardIsHiding:Bool = false

struct ChatMessage {
    let text: String
    let isIncoming: Bool
}

class ViewController: UITableViewController {
    
    fileprivate let cellId = "id123"
    
    var chatMessages = [ChatMessage(text: "", isIncoming: true)]
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 127/255, blue: 240/255, alpha: 1)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSend), for:.touchUpInside )
        return button
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your message..."
        return textField
    }()
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Qwerty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        view.addSubview(messageInputContainerView)
        
        
        
        messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["messageInputContainerView": messageInputContainerView]
        
        let widthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[messageInputContainerView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        
        //had to hardcode the value of 503 ----------come back to this if I can
        let heightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[messageInputContainerView(48)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        let horizontalConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
       
        
        //trying to get the textfield to stick ----- methods tried -----
        
        //messageInputContainerView.topAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 0).isActive = true
        
        //NSLayoutConstraint(item: messageInputContainerView, attribute: .top, relatedBy: .equal, toItem: navigationController, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        //let bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -300)
//       tableView.tableHeaderView = messageInputContainerView
//        CGRect frame = .frame;
        
       
       view.addConstraints(widthConstraints)
       view.addConstraints(heightConstraints)
       view.addConstraints([horizontalConstraint, verticalConstraint])
        
        //view.addConstraint(bottomConstraint)
        
        sendButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        sendButton.layer.cornerRadius = 10
       self.hideKeyboard()
       setupInputComponents()
        
      
        
        if(inputTextField.isFirstResponder){
            print("keyboard up!")
        }
    }
    
    @objc func handleSend(){
      // print(inputTextField.text)
        
        let request = ApiAI.shared().textRequest()
        
        
        let chatMessageBool:Bool = !chatMessages[chatMessages.count - 1].isIncoming
        
        //let input: String?
        
        if let text = inputTextField.text, text != ""{
            request?.query = text
        }else{
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
                let response = response as! AIResponse
                if let textResponse = response.result.fulfillment.speech {
                self.speechAndText(text: textResponse)
                }
                }, failure: { (request, error) in
                print(error!)
                })
        
        ApiAI.shared().enqueue(request)
        //messageField.text = ""
        
        
        if let input = inputTextField.text {
            chatMessages.append(ChatMessage(text: input, isIncoming: chatMessageBool))
            let messageCount = chatMessages.count - 1
           // let inserAtIndex = NSIndexPath(item: messageCount, section: 0)
            
            tableView.beginUpdates()
            //tableView.insertRows([at: NSIndexPath(row: messageCount, section: 0), with: .bottom])
            
            tableView.insertRows(at: [NSIndexPath(row: messageCount, section: 0) as IndexPath], with: .automatic)
            
            tableView.endUpdates()
            
        }else{
            return
        }
    }
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        print(text)
        
        
        let chatMessageBool:Bool = !chatMessages[chatMessages.count - 1].isIncoming
        
            chatMessages.append(ChatMessage(text: text, isIncoming: chatMessageBool))
        
            let messageCount = chatMessages.count - 1
            // let inserAtIndex = NSIndexPath(item: messageCount, section: 0)
            
            tableView.beginUpdates()
            //tableView.insertRows([at: NSIndexPath(row: messageCount, section: 0), with: .bottom])
            
            tableView.insertRows(at: [NSIndexPath(row: messageCount, section: 0) as IndexPath], with: .automatic)
            
            tableView.endUpdates()
            
        }

    
    private func setupInputComponents(){
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        messageInputContainerView.addSubview(inputTextField)
        
        messageInputContainerView.addSubview(sendButton)
        
        sendButton.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor, constant: 1).isActive = true
        
        sendButton.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor, constant: -1).isActive = true
        
        sendButton.leftAnchor.constraint(equalTo: messageInputContainerView.leftAnchor, constant: 250).isActive = true
        
        sendButton.rightAnchor.constraint(equalTo: messageInputContainerView.rightAnchor, constant: 10).isActive = true
        
        inputTextField.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor, constant: 1).isActive = true
        
        inputTextField.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor, constant: -1).isActive = true
        
        inputTextField.leftAnchor.constraint(equalTo: messageInputContainerView.leftAnchor, constant: 16).isActive = true
        
        inputTextField.rightAnchor.constraint(equalTo: messageInputContainerView.rightAnchor, constant: -1).isActive = true
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        tableView.endEditing(true)
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let chatMessage = chatMessages[indexPath.row]
        
        cell.messageLabel.text = chatMessage.text
        //cell.isIncoming = chatMessage.isIncoming
        
        //rotates color based on odd or even
        //cell.isIncoming = indexPath.row % 2 == 0
        
        cell.chatMessage = chatMessage
        
        return cell
    }
 


}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

