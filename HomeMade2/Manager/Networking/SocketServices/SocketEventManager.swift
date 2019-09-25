//
//  SocketEventManager.swift
//  TailerOnline
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import ObjectMapper


class SocketEventManager {
    
    static let shared = SocketEventManager()
    
    
    func uploadImage(image: UIImage,completion:@escaping (UploadResponse<Double,String,String>) -> Void) {
        
        let socket = SocketIOManager.sharedInstance.getSocket()
        
        let selectedImageResized = image.resizeImage(newHeight: 600)
        
        
        
        let imagedata : NSData = NSData(data: selectedImageResized.jpegData(compressionQuality: 1.0)!)
        
        let imageSize : Int  = imagedata.length
        print("Upload Image Size :\(Double(imageSize))")
        print( imagedata as Data)
        
        
        let ImageDataToServer: [String:Any] = ["name": "test.png",
                                               "size": Double(imageSize)]
//        print(ImageDataToServer)
        print("Socket EMIT startFileUpload")
        socket.emit("startFileUpload", with: [ImageDataToServer])
        
        socket.on("startUpload"){(data, ack)in
            let changeData = (data[0] as AnyObject)
            let ImagDictinary = changeData as! [String:AnyObject]
            print("Socket ON startUpload \(ImagDictinary)")
        }
        
        
        let imgData = imagedata as Data
        let uploadChunksize = 102400
        let totalsize = imgData.count
        var offset = 0
        
        socket.on("moreData"){(data, ack)in
            
            let modified = (data[0] as AnyObject)
            let OtherImageDictinary = modified as! [String: AnyObject]
            let moredata = MoreData(dictionary: OtherImageDictinary as NSDictionary)
            print("Socket ON moreData \(OtherImageDictinary)")
            
            completion(.progress(moredata?.data?.percent ?? 0))
            
            
            let imageData = imagedata as Data
            imageData.withUnsafeBytes{(u8Ptr:UnsafePointer<UInt8>)in
                let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
                print(totalsize)
                
                let chunkSize = offset + uploadChunksize > totalsize ? totalsize - offset : uploadChunksize
                let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                offset += chunkSize
                
                let chunkSize2 = chunk.count
                
                let imageDataupload:[String : Any]  = [
                    "fileName":   "test.png",
                    "data" : chunk as NSData ,
                    "pointer" : moredata!.data!.pointer! ,
                    "chunkSize" : chunkSize2
                ]
                
                
                print(imageDataupload)
                print("Socket EMIT uploadChunk")
                socket.emit("uploadChunk", with: [imageDataupload])
                
            }
        }
        
        socket.on("uploadCompleted") { (data, ack) in
            
            
            print("Socket ON uploadCompleted")
            
            socket.off("startUpload")
            socket.off("moreData")
            socket.off("uploadCompleted")
            
            let modified =  (data[0] as AnyObject)
            
            //Map your response Object
            if let rootModel = Mapper<RootUploadCompleteModel>().map(JSONObject: modified) {
                let path = (rootModel.data?.fileName!)!
                completion(.path(path))
            }
            else {
//                nvMessage.showStatusError(body: "Response Changed")
            }
            
            
            
            
        }
    }
    func uploadImageNew(image : UIImage,progress: @escaping (Double) -> Void, completion: @escaping (UploadDataResponse?, String?) -> Void) {
        
        let socket = SocketIOManager.sharedInstance.getSocket()
        
        let selectedImageResized = image.resizeImage(newHeight: 600)
        
        
        
        let imagedata : NSData = NSData(data: selectedImageResized.jpegData(compressionQuality: 1.0)!)
        
        let imageSize : Int  = imagedata.length
//        print("Upload Image Size :\(Double(imageSize))")
//        print( imagedata as Data)
        
        
        let ImageDataToServer: [String:Any] = ["name": "test.png",
                                               "size": Double(imageSize)]
        //        print(ImageDataToServer)
        print("Socket EMIT startFileUpload")
        socket.emit("startFileUpload", with: [ImageDataToServer])
        
        socket.on("startUpload"){(data, ack)in
            let changeData = (data[0] as AnyObject)
            let ImagDictinary = changeData as! [String:AnyObject]
            print("Socket ON startUpload \(ImagDictinary)")
        }
        
        
        let imgData = imagedata as Data
        let uploadChunksize = 102400
        let totalsize = imgData.count
        var offset = 0
        
        socket.on("moreData"){(data, ack)in
            
            let modified = (data[0] as AnyObject)
            let OtherImageDictinary = modified as! [String: AnyObject]
            let (moreData , error) = MoreData1.decode(dictionary: OtherImageDictinary, modelType: MoreData1.self)
            print("Socket ON moreData \(OtherImageDictinary)")
            progress(moreData?.data?.percent ?? 0.0)
            let imageData = imagedata as Data
            imageData.withUnsafeBytes{(u8Ptr:UnsafePointer<UInt8>)in
                let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
                print("Total Size :\(totalsize)")
                
                let chunkSize = offset + uploadChunksize > totalsize ? totalsize - offset : uploadChunksize
                let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                offset += chunkSize
                
                let chunkSize2 = chunk.count
                
                let imageDataupload:[String : Any]  = [
                    "fileName":   "test.png",
                    "data" : chunk as NSData ,
                    "pointer" : moreData!.data!.pointer! ,
                    "chunkSize" : chunkSize2
                ]
                
                
//                print(imageDataupload)
                print("Socket EMIT uploadChunk")
                socket.emit("uploadChunk", with: [imageDataupload])
                
            }
        }
        
        socket.on("uploadCompleted") { (data, ack) in
            print("Socket ON uploadCompleted")
            socket.off("startUpload")
            socket.off("moreData")
            socket.off("uploadCompleted")
            let modified =  (data[0] as AnyObject)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: modified, options: .prettyPrinted)
                // here "jsonData" is the dictionary encoded in JSON data
                do {
                    let apiResponse = try JSONDecoder().decode(UploadDataResponse.self, from: jsonData)
                    
                    _ = (apiResponse.data?.fileName!)!
                    completion(apiResponse, nil)
                }
                catch let error {
                    print("Parsing Data to Object Error :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completion(nil, error)
                }
            } catch let error {
                print("Dictionary to Data error :\(error)")
                let error = "Something went wrong, please try again later".localized
                completion(nil, error)
            }

        }
    }
    
    
    func uploadAudioFile(url: URL,completion:@escaping (UploadResponse<Double,String,String>) -> Void) {
        
        let socket = SocketIOManager.sharedInstance.getSocket()
        
         var imagedata = Data()
        
        
        do {
            imagedata = try Data(contentsOf: url)
        } catch {
            print ("loading image file error")
        }
     
        
        let imageSize : Int  = imagedata.count
        print(Double(imageSize))
        print( imagedata as Data)
        
        
        let ImageDataToServer: [String:Any] = ["name": "recording.m4a",
                                               "size": Double(imageSize)]
        print(ImageDataToServer)
        
        socket.emit("startFileUpload", with: [ImageDataToServer])
        
        socket.on("startUpload"){(data, ack)in
            let changeData = (data[0] as AnyObject)
            let ImagDictinary = changeData as! [String:AnyObject]
            print("Socket ON \(ImagDictinary)")
        }
        
        
        let imgData = imagedata as Data
        let uploadChunksize = 102400
        let totalsize = imgData.count
        var offset = 0
        
        socket.on("moreData"){(data, ack)in
            
            let modified = (data[0] as AnyObject)
            let OtherImageDictinary = modified as! [String: AnyObject]
            let moredata = MoreData(dictionary: OtherImageDictinary as NSDictionary)
            print(OtherImageDictinary)
            
            completion(.progress(moredata?.data?.percent ?? 0))
            
            
            let imageData = imagedata as Data
            imageData.withUnsafeBytes{(u8Ptr:UnsafePointer<UInt8>)in
                let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
                print(totalsize)
                
                let chunkSize = offset + uploadChunksize > totalsize ? totalsize - offset : uploadChunksize
                let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                offset += chunkSize
                
                let chunkSize2 = chunk.count
                
                let imageDataupload:[String : Any]  = [
                    "fileName":   "recording.m4a",
                    "data" : chunk as NSData ,
                    "pointer" : moredata!.data!.pointer! ,
                    "chunkSize" : chunkSize2
                ]
                
                
                print(imageDataupload)
                
                socket.emit("uploadChunk", with: [imageDataupload])
                
            }
        }
        
        socket.on("uploadCompleted") { (data, ack) in
            
            
            socket.off("startUpload")
            socket.off("moreData")
            socket.off("uploadCompleted")
            
            let modified =  (data[0] as AnyObject)
            
            //Map your response Object
            if let rootModel = Mapper<RootUploadCompleteModel>().map(JSONObject: modified) {
                let path = (rootModel.data?.fileName!)!
                completion(.path(path))
            }
            else {
//                nvMessage.showStatusError(body: "Response Changed")
            }
            
            
            
            
        }
    }
}
