//
//  MXManager.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/26.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit

typealias Completion = ([String: Any])->Void

let ReturnName = "object"

class MXManager : NSObject {
    
    internal var cachedTarget : [String: NSObject.Type] = [String: NSObject.Type]()
    // Singleton
    static let sharedInstance = MXManager()
    
    private override init() {
        super.init()
    }

    // MARK: Basic Function
    func performAction(withTarget target: String, action: String, parameters:[String: Any], shouldCacheTarget: Bool, completion: Completion) {
        // target class
        let targetClassName = String.init(format: "%@.%@", Bundle.main.infoDictionary!["CFBundleName"] as! String, target)
        
        var targetObj : NSObject!
        
        var targetClass = self.cachedTarget[targetClassName]
        
        if targetClass == nil {
            targetClass = NSClassFromString(targetClassName) as? NSObject.Type
            guard  targetClass != nil else {
                completion(["result": false, "message": "class not found"])
                return
            }
        }
        targetObj = targetClass!.init()

        // cached
        if shouldCacheTarget {
            self.cachedTarget[targetClassName] = targetClass!
        }
        // get action
        let actionName = String.init(format: "%@", action)
        
        let selector = NSSelectorFromString(actionName)
        
        if targetObj == nil {
            self.noTargetResponse(parameters: parameters, completion: completion)
            return
        }
        
        if targetObj!.responds(to: selector) {
             let result = self.safePerformAction(target: targetObj!, action: selector, parameters: parameters)
            completion(["result": true, "message": "action execute success", ReturnName: result as Any])
        } else {
            // Find notfound action, if it`s exist.
            let notfoundAction = NSSelectorFromString("notFound")
            if targetObj!.responds(to: notfoundAction) {
                let result = self.safePerformAction(target: targetObj!, action: notfoundAction, parameters: parameters)
                completion(["result": true, "message": "notFound action execute success", ReturnName: result as Any])
                
            } else {
                self.noTargetResponse(parameters: parameters, completion: completion)
            }
        }
    }
    
    func performUrl(withUrl url: URL, completion: Completion) {
        var parameters = [String: Any]()
        
        // cann`t extract the url
        guard let urlString = url.query else {
            completion(["result":false, "message": "invalid url"])
            return
        }
        for para in  urlString.components(separatedBy: "&") {
            let kv = para.components(separatedBy: "=")
            if kv.count < 2 {
                continue
            }
            parameters[kv[0]] = kv[1]
        }
        // do this for safe, refuse the connect from cloud
        let actionName = url.path.replacingOccurrences(of: "/", with: "")
        
        if actionName.hasPrefix("native") {
            completion(["result":false, "message": "invalid action"])
            return
        }
        
        // perform action
        guard let host = url.host else {
            completion(["result":false, "message": "invalid host"])
            return
        }
        self.performAction(withTarget: host, action: actionName, parameters: parameters, shouldCacheTarget: false, completion: completion)
    }
    
    // MARK: Internal Function
    private func noTargetResponse(parameters : [String: Any], completion: Completion) {
        let notFoundString = String.init(format: "%@.%@", Bundle.main.infoDictionary!["CFBundleName"] as! String, "unKnown")
        
        guard let notFoundClass = NSClassFromString(notFoundString) else {
            completion(["result": false, "message": "can not found anything..."])
            return
        }
       
        let selector = NSSelectorFromString("notFound")
        
        let notFoundObj = (notFoundClass as! NSObject.Type).init()
        if notFoundObj.responds(to: selector) {
            let returnObject = self.safePerformAction(target: notFoundObj, action: selector, parameters: parameters)
            completion(["result": false, "message": "The indicate target with action can not found", ReturnName: returnObject as Any])
        } else {
            completion(["result": false, "message": "can not found anything..."])
        }
    }
    
    private func safePerformAction(target : NSObject, action : Selector, parameters: [String: Any]) -> AnyObject? {
      return target.perform(action, with: parameters)?.takeUnretainedValue()
    }
}
