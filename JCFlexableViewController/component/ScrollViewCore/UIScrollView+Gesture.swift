//
//  UIScrollView+Gesture.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/18.
//

import UIKit

public let JCScrollViewTag: Int = 23333
private var scrollWithOtherKey: Int = 0
private var dragingSelfKey: Int = 0

extension UIScrollView {
    
    /// 是否识别其它ScrollView的手势
    var scrollWithOther: Bool {
        set {
            objc_setAssociatedObject(self, &scrollWithOtherKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let value = objc_getAssociatedObject(self, &scrollWithOtherKey) as? Bool {
                return value
            }
            return false
        }
    }
    
    /// 区分当前是否滑动自身
    var dragingSelf: Bool {
        set {
            objc_setAssociatedObject(self, &dragingSelfKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let value = objc_getAssociatedObject(self, &dragingSelfKey) as? Bool {
                return value
            }
            return false
        }
    }
    
    static func swizzle() {
        self.swizzle(sel: #selector(UIGestureRecognizerDelegate.gestureRecognizer(_:shouldRecognizeSimultaneouslyWith:)), with: #selector(jc_gesture(_:shouldRecognizeSimultaneouslyWith:)))
    }
    
    @objc dynamic func jc_gesture(_ gesture: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGesture: UIGestureRecognizer) -> Bool {
        //根据tag来匹配需要识别的手势
        if self.scrollWithOther && otherGesture.view?.tag == JCScrollViewTag {
            self.dragingSelf = false
            return true
        }
        return self.jc_gesture(gesture, shouldRecognizeSimultaneouslyWith: otherGesture)
    }
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer {
            self.dragingSelf = true
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
}

extension UIApplication {

    private static let runOnce: Void = {
        UIScrollView.swizzle()
    }()

    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }

}
