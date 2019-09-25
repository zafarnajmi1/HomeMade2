//
//  ChatVC.swift
//  HomeMade2
//
//  Created by Apple on 09/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class ChatVC: BaseImagePickerVC {

    @IBOutlet weak var tbl_chat : UITableView!
    @IBOutlet weak var txt_message : UITextField!
    @IBOutlet weak var btn_attach : LoaderButton!
    
    
    @IBOutlet weak var lbl_productName : UILabel!
    @IBOutlet weak var lbl_productPrice : UILabel!
    @IBOutlet weak var img_productImage : UIImageView!
    
    
    var isLoadMoreAllowed = false
    var skip : Int = 0
    
//    var navigationTitle: String?
    var notificationId: String?
//    var product : Product?
//    var store : Store?
    var conversation: ListConversation?
//    var fetchingMore = false
//    var delegate: CallBackDelegate?
    
    var messages : [Message] = []
    
    let socket = SocketIOManager.sharedInstance.getSocket()
    var user : User {
        get {
            return AppSettings.loggedInUser()!
        }
    }
    

    

    static func viewController() -> ChatVC
    {
        return UIStoryboard.chat.instantiateViewController(withIdentifier: ChatVC.className) as! ChatVC
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    override func setupView() {
        setBackBarButton()
        
        tbl_chat.transform = CGAffineTransform(scaleX: 1, y: -1)
        tbl_chat.register(SentMessageCell.nib, forCellReuseIdentifier: SentMessageCell.className)
        tbl_chat.register(SentImageCell.nib, forCellReuseIdentifier: SentImageCell.className)
        tbl_chat.register(ReceivedMessageCell.nib, forCellReuseIdentifier: ReceivedMessageCell.className)
        tbl_chat.register(ReceivedImageCell.nib, forCellReuseIdentifier: ReceivedImageCell.className)
        
        
        if loggedInUserAccountType == .seller{
            let firstName = conversation?.user?.firstName ?? ""
            let lastName = conversation?.user?.lastName ?? ""
            navigationItem.title = "\(firstName) \(lastName)"
        }
        else{
            navigationItem.title = "\(conversation?.store?.storeName ?? "")"
        }

        if let product = conversation?.product
        {
            img_productImage.kf.setImage(with: URL(string: product.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_small)
            lbl_productName.text = product.title
            lbl_productPrice.text  = product.price?.showPrice?.formattedText
        }
        fetchMessageList()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func notificationSeenLlist() {
        guard let id = notificationId else {
            return
        }

        var seenList = [String]()
        seenList.append(id)
        let params = ["notifications": seenList]
        print(params)

        if(seenList.count > 0){
            self.socket.emit("notificationsSeen", with: [params])
        }
    }
    func loadTableForFirstTime(){
        tbl_chat.reloadData()
        if messages.count > 0{
            tbl_chat.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
            
        }
        
        isLoadMoreAllowed = true
    }
    func fetchMessageList() {


        ///notification  read request
        self.notificationSeenLlist()

        guard let conversationId = conversation?._id else { return }

        //fetch message List
        beginBatchFetch()
//
//        var page : Int = 1
//
//        if let pagination = pagination {
//            page = pagination.next ?? 1
//        }
//
//        let params = ["conversation":conversationId,
//                      "page":page] as [String : Any]
//
//        self.socket.emit("messagesList", with: [params])


        self.socket.on("newConversation") { (data, ack) in
            let modified =  (data[0] as AnyObject)
//            print(modified)
            self.printResponse(dictionary: modified as! [String : AnyObject], message: "New Conversation Response")
            
            

//            if let rootModel = Mapper<ConversationAPIResponse>().map(JSONObject: modified) {
//
//                if let conversationId = rootModel.data?.conversation?.id {
//                    let params = [ "conversation":conversationId,
//                                   "page": self.page] as [String : Any]
//                    self.socket.emit("messagesList", with: [params])
//                }
//
//            }

        }

        self.socket.on("getConversation") { (data, ack) in


            let modified =  (data[0] as AnyObject)

            let dictionary = modified as! [String: AnyObject]

            self.printResponse(dictionary: dictionary, message: "Get Conversation List")
//            print("Get Conversation List :\(dictionary)")

//            if let rootModel = Mapper<ConversationAPIResponse>().map(JSONObject: modified) {
//
//                if let conversationId = rootModel.data?.conversation?.id {
//                    let params = [ "conversation":conversationId,
//                                   "page": self.page] as [String : Any]
//                    self.socket.emit("messagesList", with: [params])
//                }
//
//            }

        }

        

//        self.socket.on("conversationsList") { (data, ack) in
//
//            let params = ["conversation":conversationId,
//                          "page": 1] as [String : Any]
//
//            self.socket.emit("messagesList", with: [params])
//        }


        self.socket.on("newMessage") { [weak self] (data, ack) in

            let modified =  (data[0] as AnyObject)
            let dictionary = modified as! [String: AnyObject]
            let (chatResponse,error) = NewMessageServerResponse.decode(dictionary: dictionary, modelType: NewMessageServerResponse.self)
            
            self?.checkResponse(response: chatResponse, error: error)
            
            if let message = chatResponse?.data?.message{
                
                self?.messages.insert(message, at: 0)
                self?.tbl_chat.reloadData()
                self?.tbl_chat.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
                
            }
            self?.printResponse(dictionary: dictionary, message: "New Message")


        }

        
    }
    func mySelectedImage(image: UIImage) {
        
        
        
//        SocketEventManager.shared.uploadImage(image: image) { (result) in
//            switch result {
//            case .progress(let value):
//                let counter = Int(value)
//                print("File Upload Progress Status:\(counter)")
//            case .path(let fileName):
//                self.attachBtn.hideLoading()
//                let params = [
//                    "conversation":  self.conversation!.id!,
//                    "type" : "image/jpeg",
//                    "fileName" : fileName
//                    ] as [String : Any]
//
//                self.socket.emit("sendMessage", with: [params])
//            }
//        }
    }
    func beginBatchFetch(skip : Int = 0) {
        self.skip = skip
        listenBatchFetch()
        guard let conversationId = conversation?._id else { return }
//        fetchingMore = true

//        print(self.objPage)
//        print(self.totalPage)
            let params = ["conversation": conversationId,"skip": skip] as [String : Any]
            self.socket.emit("messagesList", with: [params])
        
    }
    func listenBatchFetch(){
        self.socket.once("messagesList") { [weak self] (data, ack) in
            
            let modified =  (data[0] as AnyObject)
            let dictionary = modified as! [String: Any]
            let (chatResponse,error) = ChatServerResponse.decode(dictionary: dictionary, modelType: ChatServerResponse.self)
            //            self?.messages = chatResponse?.data?.messages ?? []
//            self?.pagination = chatResponse?.data?.pagination
            if var messageList = chatResponse?.data?.messages{
                messageList.reverse()
                self?.isLoadMore = (messageList.count > 0)
                if self?.skip == 0 {
                    self?.messages = messageList
                    self?.loadTableForFirstTime()
                }
                else{
                    self?.messages += messageList
                    self?.tbl_chat.reloadData()
                }
            }
            self?.printResponse(dictionary: dictionary, message: "Message List ")
            
            
            
  
            
        }
    }
    //MARK:- SendMessage
    @IBAction func onClick_send(_ sender: UIButton) {
        
        guard let msg = txt_message.text else {
            return
        }
        if (msg  == ""){
            nvMessage.showStatusWarning(body: "Please Write something")
        }
        else{
            let conversationID = ["conversation":conversation?._id!,
                                  "content" : msg]
            self.socket.emit("sendMessage", with: [conversationID])
            self.txt_message.text = ""
        }

    }
    @IBAction func onClick_photo(_ sender: UIButton) {
        showImagePicker()
    }
    override func uploadImage(image: UIImage) {
        btn_attach.showLoading()
        SocketEventManager.shared.uploadImageNew(image: image, progress: { (progress) in
            print("Progress :\(image)")
        }) {
            [weak self] (response, error) in
            self?.btn_attach.hideLoading()
            if self?.checkResponse(response: response, error: error) ?? false{
                guard let fileName = response?.data?.fileName, let convID = self?.conversation?._id
                    else {
                        return
                }
                let params = [
                    "conversation":  convID,
                    "type" : "image/jpeg",
                    "fileName" : fileName
                    ] as [String : Any]
                
                self?.socket.emit("sendMessage", with: [params])
            }
        }
        
    }
    func printResponse(dictionary : [String: Any], message : String){
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            let jsonString = String.init(data: jsonData, encoding: .utf8)
            print("\(message) :\(jsonString ?? "Unknown String")")
            //            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        catch let error {
            print("Dictionary to Data error :\(error)")
            
            //                self.showError(body: error)
            //                print(error.localizedDescription)
        }
    }

}
extension ChatVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.row == (messages.count - 1) && isLoadMoreAllowed && isLoadMore{
            beginBatchFetch(skip: messages.count)
        }
        
        let message = messages[indexPath.row]
        if message.sender == user._id{
            if message.mimeType == "text" {
                let cell = tableView.dequeueReusableCell(withIdentifier: SentMessageCell.className) as! SentMessageCell
                cell.transform = tableView.transform
                cell.loadCell(message: message)
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: SentImageCell.className) as! SentImageCell
                cell.transform = tableView.transform
                cell.loadCell(message: message)
                return cell
            }
        }
        else{
            if message.mimeType == "text" {
                let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedMessageCell.className) as! ReceivedMessageCell
                cell.transform = tableView.transform
                cell.loadCell(message: message, listObject: conversation!)
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedImageCell.className) as! ReceivedImageCell
                cell.transform = tableView.transform
                cell.loadCell(message: message, listObject: conversation!)
                return cell
            }
        }
//        if true {
//
//        }
//        else  {
//            if true {
//                let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedMessageCell.className) as! ReceivedMessageCell
//                return cell
//            }
//            else{
//                let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedImageCell.className) as! ReceivedImageCell
//                return cell
//            }
//        }
    }
    
    
}
