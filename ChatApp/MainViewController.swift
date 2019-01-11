//
//  MainViewController.swift
//  ChatApp
//
//  Created by Edwin  O'Meara on 1/10/19.
//  Copyright © 2019 Edwin  O'Meara. All rights reserved.
//
//####################################dont use ##############################################################
import UIKit

struct Message {
    let text: String
    let isIncoming: Bool
}

let messageInputContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.red
    return view
}()

let inputTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter your message..."
    return textField
}()

class MainViewController: UIViewController {
    
    fileprivate let cellId = "id123"
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    let Messages = [Message(text: "Hello", isIncoming: true), Message(text: "World 0000000000000000021390909d090e90sd9c0e9w0f9sd", isIncoming: false), Message(text: "byekgifirufifififidkdkdkdkddkdkdkd", isIncoming: true), Message(text: "Wo???????rld", isIncoming: false),Message(text: "Helsdoioioioioooiooioilo", isIncoming: true), Message(text: "World", isIncoming: false),
        ]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Qwerty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        // Do any additional setup after loading the view.
        
       // view.addSubview(messageInputContainerView)
        
        //messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let chatMessage = Messages[indexPath.row]
        
        cell.messageLabel.text = chatMessage.text
        //cell.isIncoming = chatMessage.isIncoming
        
        //rotates color based on odd or even
        //cell.isIncoming = indexPath.row % 2 == 0
        
        //cell.Message = chatMessage
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}
