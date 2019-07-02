//
//  BatchTextQRCodeModule.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/30.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit

extension MXManager {
    func createBatchTextQRCodeVC(parameters: [String: Any], completion: (_ vc: BatchTextQRCodeViewController?)->Void) {
        var newParameters = [String: Any]()
        
        for key in parameters.keys {
            newParameters[key] = parameters[key]
        }
        
        self.performAction(withTarget: "BatchTextQRCodeViewController", action: "initAttributesWithParams:", parameters: newParameters, shouldCacheTarget: true) { (result : [String : Any]) in
            
            print("中间件结果: \(result)")
            
            guard let _ = result["result"] as? Bool else {
                completion(nil)
                return
            }
            
            guard let vc = result[ReturnName] as? BatchTextQRCodeViewController else {
                completion(nil)
                return
            }
            
            completion(vc)
        }
    }
}
