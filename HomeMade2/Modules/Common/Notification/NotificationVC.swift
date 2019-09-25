//
//  NotificationVC.swift
//  HomeMade2
//
//  Created by Apple on 10/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class NotificationVC: BaseVC {
    
    //MARK: Properties.
    @IBOutlet weak var tbl_notifications : UITableView!
    var notificationList : [Notification] = []
    let socket = SocketIOManager.sharedInstance.getSocket()
    
    
    static func viewController() -> NotificationVC{
        
        return UIStoryboard.commonStoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
    }
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        setBackBarButton()
        tbl_notifications.register(NotificationCell.nib, forCellReuseIdentifier: NotificationCell.className)
        self.title = "NOTIFICATIONS".localized
        notificationSocket()
    }
    
    //MARK: Network
    func notificationSocket(){
        isRequestSent = true
        var page : Int = 1
        
        if let pagination = pagination{
            page = (pagination.page ?? 0) + 1
        }
        let dic = ["page": page] as [String: Any]
        
        print("Socket Emit notificationsList :\(dic)")
        socket.emit("notificationsList",dic)
        if page == 1 {
          self.startAnimating()
        }
        socket.once("notificationsList"){ [weak self] (data, ack)in
//            self.tableView.stopLoader()
            
            //MARK:- StopProccessHere
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self?.hideNvloader()
            let modified = data[0] as! [String : Any]
            let (response,error)  = NotificationServerResponse.decode(dictionary: modified, modelType: NotificationServerResponse.self)
            if self?.checkResponse(response: response, error: error) ?? false{
                self?.pagination = response?.data?.pagination
                if let pagination = self?.pagination{
                    if pagination.page == 1{
                        self?.notificationList = response?.data?.notifications ?? []
                    }
                    else{
                        self?.notificationList += response?.data?.notifications ?? []
                    }
                }
                self?.tbl_notifications.reloadData()
            }
            AppSettings.printResponse(dictionary: modified , message: "Socket Once Notificaiton List")
//            if let obj =  Mapper<NotificationAPIResponse>().map(JSONObject: modified) {
//
//
//                if obj.success == true {
//
//                    self.totalPage = (obj.data?.pagination?.pages)!
//
//                    if self.page == 1 {
//                        self.notificationList = (obj.data?.notifications)! // default list
//                        self.page += 1
//                    }
//                    else {
//
//                        if self.page <= self.totalPage {
//
//                            self.page += 1 //increment in current page
//
//                            for model in (obj.data?.notifications)! {
//                                self.notificationList.append(model)
//                            }
//                        }
//                    }
//
//                    let count = obj.data?.unseenNotificationsCount ?? 0
//                    AppUserDefault.shared.notificationCount = count
//                    UIApplication.shared.applicationIconBadgeNumber = count
//
//                    self.tabBarController?.increaseBadge(indexOfTab: 2, num: "\(count)")
//
//                    if self.notificationList.count == 0 {
//                        self.tableView.setEmptyView()
//                    }
//                    else {
//                        self.tableView.reloadData()
//                        print(self.notificationList.count)
//                    }
//
//
//                }
//                else {
//                    let msg = obj.message
//                    nvMessage.showError(body: msg ?? "")
//                }
//            }
            
        }
        
        
        socket.on("newNotification"){(data , ack )in
            let dictionary = data[0] as! [String: AnyObject]
            AppSettings.printResponse(dictionary: dictionary, message: "Socket ON New Notification")
            let dic = ["page": 1] as [String: Any]
            print("Soceket Emit notificationsList :\(dic)")
            self.socket.emit("notificationsList", dic)
        }
        socket.on("removeNotifications"){(data , ack)in
            let modified = data[0] as AnyObject
            let dictionary = modified as! [String: AnyObject]
            AppSettings.printResponse(dictionary: dictionary, message: "Socket ON Remove Notificaiton")
        }
        socket.on("notificationsChanged"){(data, ack)in
            let dictionary = data[0] as! [String: AnyObject]
            AppSettings.printResponse(dictionary: dictionary, message: "Socket ON Notifiactions Changed")
            let dic = ["page": 1] as [String: Any]
            print("Soceket Emit notificationsList :\(dic)")
            self.socket.emit("notificationsList",dic)
        }
        
        
        
    }
    
    
//    func seenNotificationAray() {
//        
//        let socket = SocketIOManager.sharedInstance.getSocket()
//        
//        
//        var seenArray = [String]()
//        for i in 0 ..< self.notificationList.count{
//            
//            let seendata = self.notificationList[i]
//            print(seendata.seen!)
//            if(seendata.seen!){
//                
//            }
//            else{
//                
//                seenArray.append(seendata.id!)
//            }
//        }
//        
//        let json2 = ["notifications": seenArray]
//        if(seenArray.isEmpty){
//            
//        }
//        else{
//            socket.emit("notificationsSeen", with: [json2])
//        }
//    }
//    
//    
//    func removeNotification(i : Int) {
//        
//        let socket = SocketIOManager.sharedInstance.getSocket()
//        
//        var seenArray = [String]()
//        let seenData = self.notificationList[i]
//        print(seenData.seen!)
//        seenArray.append(seenData.id!)
//        let json2 = ["notifications": seenArray]
//        
//        if(seenArray.count > 0) {
//            
//            socket.emit("removeNotifications", with: [json2])
//            self.notificationList.remove(at: i)
//            
//            self.tableView.reloadData()
//        }
//    }
//    
//    func removeAllNotification() {
//        
//        let socket = SocketIOManager.sharedInstance.getSocket()
//        
//        var SeenArr = [String]()
//        print(self.notificationList.count)
//        
//        for i in 0 ..< self.notificationList.count {
//            
//            let seenData =  self.notificationList[i]
//            print(seenData.seen!)
//            SeenArr.append(seenData.id!)
//        }
//        
//        
//        let json2 = ["notifications":SeenArr ]
//        print(json2)
//        
//        if SeenArr.count > 0{
//            socket.emit("removeNotifications", with: [json2])
//        }
//        
//    }
    

}

extension NotificationVC: UITableViewDataSource, UITableViewDelegate, NotificationCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == notificationList.count - 1 && ((pagination?.pages)! > (pagination?.page)!) && !isRequestSent {
            notificationSocket()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.className) as! NotificationCell
        let notificaiton = notificationList[indexPath.row]
        cell.delegate = self
        cell.loadCell(object: notificaiton)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notificaiton = notificationList[indexPath.row]
        
        
       
        if !(notificaiton.seen ?? false){
            notificaiton.seen = true
            let list = [notificaiton._id]
            let parms = ["notifications": list]
            print("Socket Emit notificationsSeen :\(parms)")
            socket.emit("notificationsSeen", with: [parms])
            
            let cell = tableView.cellForRow(at: indexPath) as! NotificationCell
            cell.loadCell(object: notificaiton)
//            cell.unseenView.isHidden = true
        }
        
        
        
        
        switch notificaiton.action {
        case "NEW_ORDER":
            newOrder(notification: notificaiton)
        case "ORDER_SHIPPED":
            orderShipped(notification: notificaiton)
        case "ORDER_RECEIVED":
            orderReceived(notification: notificaiton)
        case "ORDER_REFUNDED":
            orderRefunded(notification: notificaiton)
        case "OPEN_CONVERSATION":
            openConversation(notification: notificaiton)
        case "CART_FLASHED":
            cartFlashed(notification: notificaiton)
        case "CART_REMOVED":
            cartRemoved(notification: notificaiton)
        default:
            print("No Case excuted")
        }
    }
    func removeNotification(object : Notification){
    
        
        let socket = SocketIOManager.sharedInstance.getSocket()
//        let notifiactionID = notificationList[index]._id
        
//        var notificationIds = [String]()
//        let notification = self.notificationList[index]
//        notificationIds.append(notification.id!)
        
        
        let alert = UIAlertController(title: "Alert?", message: "Do you want to delete this notification?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Yes".localized, style: .destructive, handler: { [weak self] (action) in
            let json = ["_id": object._id!]
            print("Socket Emit removeNotifications:\(json)")
            socket.emit("removeNotifications", with: [json])
            
            for (index, noti) in (self?.notificationList ?? []).enumerated(){
                if noti._id == object._id{
                    self?.notificationList.remove(at: index)
                    self?.tbl_notifications.reloadData()
                    break
                }
            }
        }))
        present(alert, animated: true, completion: nil)
        
        
        

        
        
    }
    /*
     1- NEW_ORDER
     2- ORDER_SHIPPED
     3- ORDER_RECEIVED
     4- ORDER_REFUNDED
     5- OPEN_CONVERSATION
     6- CART_FLASHED
     7- CART_REMOVED
     */
    func newOrder(notification : Notification){
//        if loggedInUserAccountType == .seller {
            goToOrderListing()
//        }
//        else{
//
//        }
//        let orderDetail = SellerOrderDetailVC.viewController()
//        orderDetail.order = notification.
        
    }
    func orderShipped(notification : Notification){
//        if loggedInUserAccountType == .seller {
           goToOrderListing()
//        }
//        let orderDetail = BuyerOrderDetailVC.viewController()
//        orderDetail.orderID = notification.extras?.product
//        navigationController?.pushViewController(orderDetail, animated: true)
    }
    func orderReceived(notification : Notification){
//        if loggedInUserAccountType == .seller {
            goToOrderListing()
//        }
    }
    func orderRefunded(notification : Notification){
//        if loggedInUserAccountType == .seller {
            goToOrderListing()
//        }
    }
    func openConversation(notification : Notification){
        
        startAnimating()
        let params = ["_id" : notification.extras?.conversation,
                      "product" : notification.extras?.product]
        print("Socket Emit getConversation:\(params)")
        socket.emit("getConversation",params)
        
        socket.once("getConversation"){ [weak self] (data, ack)in
            self?.stopAnimating()
            let modified = data[0] as! [String : Any]
            
            let (response,error)  = ConversationObjectServerResponse.decode(dictionary: modified, modelType: ConversationObjectServerResponse.self)
            if self?.checkResponse(response: response, error: error) ?? false{
                let chatvc = ChatVC.viewController()
                chatvc.conversation = response?.data?.conversation
                self?.navigationController?.pushViewController(chatvc, animated: true)
            }
            AppSettings.printResponse(dictionary: modified , message: "Socekt Once Conversation Object")
            
        }
        
        
        
    }
    func cartFlashed(notification : Notification){
        gotoCart()
    }
    func cartRemoved(notification : Notification){
        gotoCart()
    }
    func goToOrderListing(){
        
        if AppSettings.loggedInUser()?.accountType == "buyer"{
            let vc = BuyerOrdersVC.viewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = SellerOrdersVC.viewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func goToOrderDetail(notification : Notification){
        let vc = BuyerOrderDetailVC.viewController()
        vc.orderID = notification.extras?.product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func gotoCart(){
        let vc = CartVC.viewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 90
//    }
    
    
}
