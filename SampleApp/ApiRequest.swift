//
//  ApiRequest.swift
//  SampleApp
//
//  Created by  dlc-it on 2019/3/30.
//  Copyright © 2019 shawnli. All rights reserved.
//

import Foundation

typealias ApiRequestCompletionHandler = (URL) -> ()

class ApiRequest {
    static let shared = ApiRequest()
    
    func get(_ url: URL, _ completionHandler: @escaping ApiRequestCompletionHandler) {
        let downloadTask = self.session.downloadTask(with: url)
        let sessionDelegate = self.session.delegate as! ApiRequestDelegate
        sessionDelegate.appendCompletionHandler(completionHandler, sessionTask: downloadTask)
        downloadTask.resume()
    }
    
    private lazy var session: URLSession = {
        return URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: ApiRequestDelegate(), delegateQueue: .main)
    }()
    
    private class ApiRequestDelegate: NSObject, URLSessionDownloadDelegate {
        private var completionHandlers = [Int: ApiRequestCompletionHandler]()
        
        func appendCompletionHandler(_ completionHandler: @escaping ApiRequestCompletionHandler , sessionTask: URLSessionTask) {
            self.completionHandlers[sessionTask.taskIdentifier] = completionHandler
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            self.completionHandlers[downloadTask.taskIdentifier]?(location)
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            self.completionHandlers[task.taskIdentifier] = nil
        }
    }
    
}
