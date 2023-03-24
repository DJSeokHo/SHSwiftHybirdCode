//
//  HttpWrapper.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2023/03/10.
//

import Foundation
import Alamofire


struct HttpFileModel {
    
    let data: Data
    let fileName: String
    let mimeType: String
    
}

struct ResponseModel {
    let data: Data? = nil
    let error: AFError? = nil
}


class HttpWrapper {
    
    public static func requestGet(
        withUrl url: String,
        withHeader header: HTTPHeaders? = nil
    ) async throws -> Data {
     
        try await withUnsafeThrowingContinuation { continuation in
           
            ILog.debug(tag: #file, content: "requestGet start \(Thread.current)")
            
            AF.request(url, method: .get, headers: header).validate().responseData { response in
                if let data = response.data {
                    
                    ILog.debug(tag: #file, content: "requestGet response data \(Thread.current)")
                    
                    continuation.resume(returning: data)
                    return
                }
                if let error = response.error {
                    
                    ILog.debug(tag: #file, content: "requestGet response error \(Thread.current)")
                    
                    continuation.resume(throwing: error)
                    return
                }
                fatalError("fatal error")
            }
        }
    }
    
    public static func requestGet(
        withUrl url: String,
        withHeader header: HTTPHeaders? = nil,
        onSuccess success: @escaping (_ data: Data?) -> Void,
        onFail fail: @escaping (_ error: AFError?) -> Void
    ) {
        AF.request(url, method: .get, headers: header).validate()

            .responseData { response in

                ILog.debug(tag: #file, content: "\(response)")

                switch response.result {
                    case .success(_):
                        ILog.debug(tag: #file, content: "\(url) success")
                        success(response.data)
                        break
                    case .failure(_):
                        ILog.debug(tag: #file, content: "\(url) failure")
                        fail(response.error)
                        break
                }
            }
    }
   
    public static func requestPost(
        withUrl url: String,
        withHeader header: HTTPHeaders? = nil,
        withFormData formData: [String: String]? = nil,
        withFiles fileList: [HttpFileModel]? = nil,
        onSuccess success: @escaping (_ data: Data?) -> Void,
        onFail fail: @escaping (_ error: AFError?) -> Void
    ) {
        
        if fileList != nil {
            
            AF.upload(multipartFormData: {
                multipartFormData in
                
                for i in 0..<fileList!.count {
                    multipartFormData.append(fileList![i].data, withName: "files", fileName: fileList![i].fileName, mimeType: fileList![i].mimeType)
                }
                
                if formData != nil {
                    for (key, value) in formData! {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
               
                
            }, to: url, method: .post, headers: header).validate().responseData {
                (response) in

                switch response.result {
                    case .success(_):
                        ILog.debug(tag: #file, content: "\(url) success")
                        success(response.data)
                        break
                    case .failure(_):
                        ILog.debug(tag: #file, content: "\(url) failure")
                        fail(response.error)
                        break
                }
            }
            
        }
        else {
            
            AF.request(url, method: .post, parameters: formData, headers: header).validate()
                .responseData {
                    (response) in

                    switch response.result {
                        case .success(_):
                            ILog.debug(tag: #file, content: "\(url) success")
                            success(response.data)
                            break
                        case .failure(_):
                            ILog.debug(tag: #file, content: "\(url) failure")
                            fail(response.error)
                            break
                    }
                }
        }
    }
    
    public static func requestPost(
        withUrl url: String,
        withHeader header: HTTPHeaders? = nil,
        withFormData formData: [String: String]? = nil,
        withFiles fileList: [HttpFileModel]? = nil
    ) async throws -> Data {
        
        try await withUnsafeThrowingContinuation { continuation in
            
            if fileList != nil {
                
                AF.upload(multipartFormData: {
                    multipartFormData in
                    
                    for i in 0..<fileList!.count {
                        multipartFormData.append(fileList![i].data, withName: "files", fileName: fileList![i].fileName, mimeType: fileList![i].mimeType)
                    }
                    
                    if formData != nil {
                        for (key, value) in formData! {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                   
                    
                }, to: url, method: .post, headers: header).validate().responseData { response in

                    if let data = response.data {
                        continuation.resume(returning: data)
                        return
                    }
                    if let error = response.error {
                        continuation.resume(throwing: error)
                        return
                    }
                    fatalError("fatal error")
                }
                
            }
            else {
                
                AF.request(url, method: .post, parameters: formData, headers: header).validate()
                    .responseData {  response in
                       
                        if let data = response.data {
                            continuation.resume(returning: data)
                            return
                        }
                        if let error = response.error {
                            continuation.resume(throwing: error)
                            return
                        }
                        fatalError("fatal error")
                        
                    }
            }
            
        }
        
    }
    
    public static func requestPut(
        withUrl url: String,
        withHeader header: HTTPHeaders? = nil,
        withFormData formData: [String: String]? = nil,
        withFiles fileList: [HttpFileModel]? = nil,
        onSuccess success: @escaping (_ data: Data?) -> Void,
        onFail fail: @escaping (_ error: AFError?) -> Void
    ) {
        
        if fileList != nil {
            
            AF.upload(multipartFormData: {
                multipartFormData in
                
                for i in 0..<fileList!.count {
                    multipartFormData.append(fileList![i].data, withName: "files", fileName: fileList![i].fileName, mimeType: fileList![i].mimeType)
                }
                
                if formData != nil {
                    
                    for (key, value) in formData! {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
            
                }
               
            }, to: url, method: .put, headers: header).validate().responseData {
                (response) in

                switch response.result {
                    case .success(_):
                        ILog.debug(tag: #file, content: "\(url) success")
                        success(response.data)
                        break
                    case .failure(_):
                        ILog.debug(tag: #file, content: "\(url) failure")
                        fail(response.error)
                        break
                }
            }
            
        }
        else {
            
            AF.request(url, method: .put, parameters: formData, headers: header).validate()
                .responseData {
                    (response) in
                   
                    switch response.result {
                        case .success(_):
                            ILog.debug(tag: #file, content: "\(url) success")
                            success(response.data)
                            break
                        case .failure(_):
                            ILog.debug(tag: #file, content: "\(url) failure")
                            fail(response.error)
                            break
                    }
                }
            
        }
        
    }
    
    public static func requestPut(
        withUrl url: String,
        withHeader header: HTTPHeaders? = nil,
        withFormData formData: [String: String]? = nil,
        withFiles fileList: [HttpFileModel]? = nil
    ) async throws -> Data {
        
        try await withUnsafeThrowingContinuation { continuation in
            
            if fileList != nil {
                
                AF.upload(multipartFormData: {
                    multipartFormData in
                    
                    for i in 0..<fileList!.count {
                        multipartFormData.append(fileList![i].data, withName: "files", fileName: fileList![i].fileName, mimeType: fileList![i].mimeType)
                    }
                    
                    if formData != nil {
                        
                        for (key, value) in formData! {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                
                    }
                   
                }, to: url, method: .put, headers: header).validate().responseData { response in
                   
                    if let data = response.data {
                        continuation.resume(returning: data)
                        return
                    }
                    if let error = response.error {
                        continuation.resume(throwing: error)
                        return
                    }
                    fatalError("fatal error")
                }
                
            }
            else {
                
                AF.request(url, method: .put, parameters: formData, headers: header).validate()
                    .responseData { response in
                        
                        if let data = response.data {
                            continuation.resume(returning: data)
                            return
                        }
                        if let error = response.error {
                            continuation.resume(throwing: error)
                            return
                        }
                        fatalError("fatal error")
                    }
            }
        }
    }
       
    public static func requestDelete(
        withUrl url: String,
        withHeader header: HTTPHeaders? = nil,
        formData: [String: String]? = nil,
        onSuccess success: @escaping (_ data: Data?) -> Void,
        onFail fail: @escaping (_ error: AFError?) -> Void
    ) {
        
        AF.request(url, method: .delete, parameters: formData, headers: header).validate()
            .responseData {
                (response) in

                switch response.result {
                    case .success(_):
                        ILog.debug(tag: #file, content: "\(url) success")
                        success(response.data)
                        break
                    case .failure(_):
                        ILog.debug(tag: #file, content: "\(url) failure")
                        fail(response.error)
                        break
                }
            }
    }
    
    public static func requestDelete(
        withUrl url: String,
        withHeader header: HTTPHeaders? = nil,
        formData: [String: String]? = nil
    ) async throws -> Data {
        
        try await withUnsafeThrowingContinuation { continuation in
            
            AF.request(url, method: .delete, parameters: formData, headers: header).validate()
                .responseData { response in

                    if let data = response.data {
                        continuation.resume(returning: data)
                        return
                    }
                    if let error = response.error {
                        continuation.resume(throwing: error)
                        return
                    }
                    fatalError("fatal error")
                }
        }
        
    }
}
