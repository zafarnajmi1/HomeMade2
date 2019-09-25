//
//  ConversationListVC.swift
//  HomeMade2
//
//  Created by Apple on 09/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SocketIO
class ConversationListVC: BaseSocketVC {

    @IBOutlet weak var tbl_list : UITableView!
    var socket : SocketIOClient{
        get{
            return SocketIOManager.sharedInstance.getSocket()
        }
    }
    var coversationList : [ListConversation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    override func setupView() {
        tbl_list.register(ConversationListCell.nib, forCellReuseIdentifier: ConversationListCell.className)
        tbl_list.tableFooterView = UIView(frame: .zero)
        tbl_list.refreshControl = refreshControl
        setupSocketEvents()
    }
    override func pullToRefreshView() {
        fetchConversations()
    }
    func setupSocketEvents(){
        
//        let socket = SocketIOManager.sharedInstance.getSocket()
        
        
        // handle connected
        print("Emit conversationsList")
        
        fetchConversations()
        setupLastMessageOn()
        
        
        
        
        
        
    }

    func fetchConversations(){
        socket.emit("conversationsList")
        socket.once("conversationsList") { [weak self] (data, ack) in
            //            self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
            //            self?.hideNvloader()
            
            let modified =  (data[0] as AnyObject)
            
            let dictionary = modified as! [String: AnyObject]
            
            print("ON conversationsList Response :\(dictionary)")
            
            let (response,error) = ConversationListResponse.decode(dictionary: dictionary, modelType: ConversationListResponse.self)
            
            if self?.checkResponse(response: response, error: error) ?? false {
                self?.coversationList = response?.data?.conversations ?? []
                
                if self?.coversationList.isEmpty ?? false{
                    self?.addEmptyView()
                }
                else{
                    self?.removeEmptyView()
                }
                self?.tbl_list.reloadData()
            }
            
            
            
            
            
            
        }
    }
    func setupLastMessageOn(){
        socket.on("lastMessage") { [weak self] (data, ack) in
            let modified =  (data[0] as AnyObject)
            let dictionary = modified as! [String: AnyObject]
            print("lastMessage ON :\(dictionary)")
            
            
            //            self?.printResponse(dictionary: dictionary, message: "Last Message Response")
            print("Emit conversationsList in lastMessage")
            self?.fetchConversations()
//            self?.socket.emit("conversationsList")
            
        }
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
extension ConversationListVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coversationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationListCell.className) as! ConversationListCell
        let object = coversationList[indexPath.row]
        
        
        cell.loadCell(object: object)
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = coversationList[indexPath.row]
        
        let chatVC : ChatVC = ChatVC.viewController()
        chatVC.conversation = object
        

        navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    
}
