//
//  NSObject+Swizzling.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/18.
//

import Foundation

public extension NSObject {
    
    static func swizzle(sel: Selector, with newSel: Selector) {
        
        guard let originalMethod = class_getInstanceMethod(self, sel),
              let newMethod = class_getInstanceMethod(self, newSel),
              let originalImp = class_getMethodImplementation(self, sel),
              let newImp = class_getMethodImplementation(self, newSel),
              let originalTypeEncoding = method_getTypeEncoding(originalMethod),
              let newTypeEncoding = method_getTypeEncoding(newMethod) else {
            return
        }
        class_addMethod(self, sel, originalImp, originalTypeEncoding)
        class_addMethod(self, newSel, newImp, newTypeEncoding)
    }
    
}
