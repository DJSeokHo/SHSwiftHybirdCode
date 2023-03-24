//
//  StorageUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2023/03/10.
//

import Foundation
import UIKit

/*
 
 Library/Preferences
 保存应用程序的偏好设置文件。NSUserDefaults类创建的数据和plist文件都放在这里；
 该目录的内容被iTunes和iCloud备份。
 
 */

class StorageUtility {
    
    /*
     AppName.app
     应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，所以不能在运行时对这个目录中的内容进行修改，
     否则会导致应用程序无法启动。
    */
    public static func getAppSandBoxDirectory() -> String {
        // 获取app沙盒的根目录（home）
        let homePath = NSHomeDirectory()
        ILog.debug(tag: "\(#file) getAppSandBoxDirectory", content: homePath)
        return homePath
    }
    
    /*
     Tmp/
     使用此目录可以编写在应用程序启动之间不需要保留的临时文件，您的应用程序应在不再需要时删除此目录中的文件，
     但是，当您的应用未运行时，系统可能会清除此目录；iTunes或iCloud不会备份此目录下的内容。
    */
    public static func getTempDirectory() -> String {
        let tempPath = NSTemporaryDirectory()
        ILog.debug(tag: "\(#file) getTempDirectory", content: tempPath)
        return tempPath
    }
    
    /*
     Documents/
     保存应用程序的重要数据文件和用户数据文件等。用户数据基本上都放在这个位置(例如从网上下载的图片或音乐文件)，
     该文件夹在应用程序更新时会自动备份，在连接iTunes时也可以自动同步备份其中的数据；该目录的内容被iTunes和iCloud备份。
    */
    public static func getDocumentDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        
        let documentPath = paths.first
        ILog.debug(tag: "\(#file) getDocumentDirectory", content: documentPath!)
        return documentPath!
    }
    
    /*
     Library/
     这个目录下有两个子目录,可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。
     该路径下的文件夹，除Caches以外，都会被iTunes备份;该目录的内容被iTunes和iCloud备份
    */
    public static func getLibraryDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        let library = paths.last
        ILog.debug(tag: "\(#file) getLibraryDirectory", content: library!)
        return library!
    }
    
    /*
     Library/Caches
     保存应用程序使用时产生的支持文件和缓存文件(保存应用程序再次启动过程中需要的信息)，还有日志文件最好也放在这个目录；
     iTunes 不会备份该目录，并且该目录下数据可能被其他工具清理掉。
    */
    public static func getLibraryCachesDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        
        let libraryCaches = paths.last
        ILog.debug(tag: "\(#file) getLibraryCachesDirectory", content: libraryCaches!)
        return libraryCaches!
    }
    
    public static func createFolder(parentFolder: String, withName name: String) {
        
        let path = NSString(string: parentFolder).appendingPathComponent(name)
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path)
        {
            ILog.debug(tag: "\(#file) createFolder", content: path)
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    public static func deleteFile(pathName: String, folderName: String, fileName: String) {
        
        let fileManager = FileManager.default
        
        let folderPath = NSString(string: pathName).appendingPathComponent(folderName)
        
        if !fileManager.fileExists(atPath: folderPath) {
            return
        }
        
        let filePath = NSString(string: folderPath).appendingPathComponent(fileName)
        
        if !fileManager.fileExists(atPath: filePath) {
            return
        }
        
        do {
            try fileManager.removeItem(atPath: filePath)
            
            ILog.debug(tag: #file, content: "delete file success")
        }
        catch {
            ILog.debug(tag: #file, content: "delete file error")
        }
    }
    
    public static func deleteFolder(pathName: String, folderName: String) {
        
        let fileManager = FileManager.default
        
        let folderPath = NSString(string: pathName).appendingPathComponent(folderName)
        
        if !fileManager.fileExists(atPath: folderPath) {
            return
        }
        
        do {
            try fileManager.removeItem(atPath: folderPath)
            
            ILog.debug(tag: #file, content: "delete folder success")
        }
        catch {
            ILog.debug(tag: #file, content: "delete folder error")
        }
    }
    
    public static func exists(path: String) -> Bool {
        
        if FileManager.default.fileExists(atPath: path) {
            return true
        }
        
        return false
    }
    
    /*
    Image Orientations
    case up
    The original pixel data matches the image's intended display orientation.

    case down
    The image has been rotated 180° from the orientation of its original pixel data.

    case left
    The image has been rotated 90° counterclockwise from the orientation of its original pixel data.

    case right
    The image has been rotated 90° clockwise from the orientation of its original pixel data.

    case upMirrored
    The image has been horizontally flipped from the orientation of its original pixel data.

    case downMirrored
    The image has been vertically flipped from the orientation of its original pixel data.

    case leftMirrored
    The image has been rotated 90° clockwise and flipped horizontally from the orientation of its original pixel data.

    case rightMirrored
    The image has been rotated 90° counterclockwise and flipped horizontally from the orientation of its original pixel data.
    */
    public static func saveImageFile(pathName: String, folderName: String, imageName: String, image: UIImage) -> (String, String, UIImage.Orientation) {
           
           createFolder(parentFolder: pathName, withName: folderName)
           
           let folderPath = NSString(string: pathName).appendingPathComponent(folderName)
           
           let imagePath = NSString(string: folderPath).appendingPathComponent(imageName)
           
           let imageData = UIImage.pngData(image)
           
           let orientation = image.imageOrientation
           
           FileManager.default.createFile(atPath: imagePath, contents: imageData(), attributes: nil)
           
           return (folderName, imageName, orientation)
       }
    
    public static func saveImageFile(pathName: String, folderName: String, imageName: String, image: UIImage) -> Bool {
        
        createFolder(parentFolder: pathName, withName: folderName)
        
        let folderPath = NSString(string: pathName).appendingPathComponent(folderName)
        
        let imagePath = NSString(string: folderPath).appendingPathComponent(imageName)
        
        let imageData = UIImage.pngData(image)
        
        return FileManager.default.createFile(atPath: imagePath, contents: imageData(), attributes: nil)
    }
    
    public static func loadImageFile(pathName: String, folderName: String, imageName: String, orientation: UIImage.Orientation) -> UIImage {
        
        let folderPath = NSString(string: pathName).appendingPathComponent(folderName)
        let imagePath = NSString(string: folderPath).appendingPathComponent(imageName)
        
        let tempImage = UIImage(contentsOfFile: imagePath)
        
        let image = UIImage(cgImage: tempImage!.cgImage!, scale: tempImage!.scale, orientation: orientation)
        
        return image
    }
}

