//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by Gabriel Theodoropoulos on 1/31/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import SocketIO
import AVKit

class SocketIOManager: NSObject {
    
    
    static let sharedInstance = SocketIOManager()
    var socket : SocketIOClient!
    var manager : SocketManager!
    var objPlayer: AVAudioPlayer?
    let notificaitonSoundURL = Bundle.main.url(forResource: "notification", withExtension: "mp3")
    var playNotificationSound : Bool = true
    
    
   private func getConfigrations() -> SocketIOClientConfiguration! {
        if let token = AppSettings.shared.userToken{
            
            let usertoken = [
                "token":  token,
                "locale" : AppSettings.language == .en ? "en" : "ar"
                ] as [String : Any]
            
            let specs : SocketIOClientConfiguration = [
            .forcePolling(false),
            .forceWebsockets(true),
            .compress,
            .path("/homemade/socket.io"),
            .connectParams(usertoken)]
        print("Socket Specs :\(specs)")
            return specs
        }
        else{
            let specs : SocketIOClientConfiguration = [
                .forcePolling(false),
                .forceWebsockets(true),
                .compress,
                .path("/homemade/socket.io")]
            print("Socket Specs :\(specs)")
            return specs
        }

    }
    
    private override init() {
        super.init()
//        setupSocket()
    }
    func setupAndEstablisConnection(){
        self.setupSocket()
        self.establishConnection()
    }
    
    //--
    
    func setupSocket(){
        let url = URL(string: "https://www.projects.mytechnology.ae/homemade")
        manager = SocketManager(socketURL: url! , config: getConfigrations())
        socket = manager.defaultSocket
    }
    
    func getSocket() -> SocketIOClient {
        return socket
    }



     // --
    func establishConnection() {
        socket.connect()
        
        socket.on("connected") { [weak self] (data, emitter) in
            print("Scoket ON connected respone :\(data)")
            self?.startListeningCommonMethods()
        }
    }

    // --
    func closeConnection() {
        socket.disconnect()
    }
    
    @discardableResult
    func once(_ event: String, callback: @escaping NormalCallback) -> UUID {
        return self.socket.once(event, callback: callback)
    }
    
    @discardableResult
    func on(_ event: String, onList addIn : inout [String], callback: @escaping NormalCallback) -> UUID {
        
        
//            addIn.append(event)
        
//        onEvents.append(event)
        return self.socket.on(event, callback: callback)
        
    }
    
    @discardableResult
    func on(_ event: String, addToOff value: Bool = true, callback: @escaping NormalCallback) -> UUID {
        
//        if value {
//            onEvents.append(event)
//        }
//        else{
//            print("Event will not turned OFF :\(event)")
//        }
        
        return self.socket.on(event, callback: callback)
        
    }
    func emit(_ event: String){
        self.socket.emit(event)
    }
    func emit(_ event: String, with items: [Any]){
        self.socket.emit(event, with: items)
    }
    func emit(_ event: String, with items: [Any] , completion: (() -> ())? = nil){
        self.socket.emit(event, with: items , completion: completion)
    }
    
    func startListeningCommonMethods() {
        

        self.socket.on("newNotification") { (data, ack) in
            let modified =  (data[0] as AnyObject)
            
            let dictionary = modified as! [String: AnyObject]
            print(dictionary)
            if(self.playNotificationSound){
                self.playAudioFile()
            }
            self.socket.emit("unseenNotifications")
            
        }
//        self.socket.on("liveBroadcastsChanged") { (data, ack) in
//            let modified =  (data[0] as AnyObject)
//
//            let dictionary = modified as! [String: AnyObject]
//            print(dictionary)
//            self.socket.emit("popularBroadcasts")
//
//        }
//        self.socket.on("newsFeedChanged") { (data, ack) in
//            let modified =  (data[0] as AnyObject)
//
//            let dictionary = modified as! [String: AnyObject]
//            print(dictionary)
//            self.socket.emit("newsFeed")
//
//        }
        self.socket.on("unseenNotifications") { (data, ack) in
            let modified =  (data[0] as AnyObject)
            
            let dictionary = modified as! [String: AnyObject]
            print("unseenNotifications ON : \(dictionary)")
            
        let (response,error) = UnseenNotificationRespons.decode(dictionary: dictionary, modelType: UnseenNotificationRespons.self)
            
            if let error = error{
                print("Unseen Notification Error :\(error)")
            }
            else{
                AppSettings.shared.unseenNotification = response?.data?.unseenNotificationsCount ?? 0
//                AppSettings.shared.unseenNotification = response?.data?.unseenNotificationsCount ?? 0
            }
//            let NotificationCount = NotificationCountModel.init(dictionary: dictionary as NSDictionary)
//
//
//            let count = "\(String(describing: NotificationCount!.data!.unseenNotificationsCount!))"
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UnseenNotifications"), object: count)
//            self.rightBarButtonItems()
            
            
        }
        self.socket.emit("unseenNotifications")
    }
    func stopListeningCommonEvents(events : [String] = []){
        for event in events {
            print("Closing Event :\(event)")
            self.socket.off(event)
        }
    }
    
    
    
    
    
    
    func playAudioFile() {
//        guard let url = Bundle.main.url(forResource: "notification", withExtension: "mp3") else { return }
//        do {
//            let audioPlayer = try AVAudioPlayer(contentsOf: notificaitonSoundURL!)
//            audioPlayer.play()
//        }
//        catch let error {
//            print("Notification could not played Error :\(error)")
//        }
        
        AudioServicesPlayAlertSound(SystemSoundID(1322))
    }
}
