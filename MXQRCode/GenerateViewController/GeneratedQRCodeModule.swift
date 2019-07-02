//
//  GeneratedQRCodeModule.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/7/1.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit

extension MXManager {
    func createGenerateQRCodeVC(parameters: [String: Any], completion: (_ vc: GeneratedViewController?)->Void) {
        var newParameters = [String: Any]()
        
        for key in parameters.keys {
            newParameters[key] = parameters[key]
        }
        
        self.performAction(withTarget: "GeneratedViewController", action: "initAttributesWithParams:", parameters: newParameters, shouldCacheTarget: true) { (result : [String : Any]) in
            
            guard let _ = result["result"] as? Bool else {
                completion(nil)
                return
            }
            
            guard let vc = result[ReturnName] as? GeneratedViewController else {
                completion(nil)
                return
            }
            
            completion(vc)
        }
    }
    
    // 获取二维码
    func generateQRCode(parameters: [String: Any], completion: (_ image: UIImage?)->Void) {
        var newParameters = [String: Any]()
        
        for key in parameters.keys {
            newParameters[key] = parameters[key]
        }
        
        let content = newParameters["content"] as? String
        
        if  content == nil {
            completion(nil)
            return
        }
        
        self.performAction(withTarget: "GeneratedViewController", action: "getQRCodeWithParams:", parameters: newParameters, shouldCacheTarget: true) { (result : [String : Any]) in
            
            guard let _ = result["result"] as? Bool else {
                completion(nil)
                return
            }
            
            guard let vc = result[ReturnName] as? UIImage else {
                completion(nil)
                return
            }
            completion(vc)
        }
    }
    
    // 获取带文本的二维码
    func generateQRCodeWithText(parameters: [String: Any], completion: (_ image: UIImage?)->Void) {
        var newParameters = [String: Any]()
        
        for key in parameters.keys {
            newParameters[key] = parameters[key]
        }
        
        let content = newParameters["content"] as? String
        
        if  content == nil {
            completion(nil)
            return 
        }
        
        self.performAction(withTarget: "GeneratedViewController", action: "getQRCodeAddTextWithParams:", parameters: newParameters, shouldCacheTarget: true) { (result : [String : Any]) in
            
            print("增加文本操作: \(newParameters), 结果为: \(result)")
            
            guard let _ = result["result"] as? Bool else {
                completion(nil)
                return
            }
            
            guard let vc = result[ReturnName] as? UIImage else {
                completion(nil)
                return
            }
            completion(vc)
        }
    }
    
    // 获取带底图的二维码
    func generateQRCodeWithMaskImg(parameters: [String: Any], completion: (_ image: UIImage?)->Void) {
        var newParameters = [String: Any]()
        
        for key in parameters.keys {
            newParameters[key] = parameters[key]
        }
        
        let content = newParameters["content"] as? String
        
        if  content == nil {
            completion(nil)
            return
        }
        
        self.performAction(withTarget: "GeneratedViewController", action: "getQRCodeAddMaskImgWithParams:", parameters: newParameters, shouldCacheTarget: true) { (result : [String : Any]) in
            
            guard let _ = result["result"] as? Bool else {
                completion(nil)
                return
            }
            
            guard let vc = result[ReturnName] as? UIImage else {
                completion(nil)
                return
            }
            completion(vc)
        }
    }
}
