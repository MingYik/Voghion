//
//  VGFullscreenPopGesture.swift
//  Voghion
//
//  Created by apple on 2022/9/9.
//

import UIKit

fileprivate struct RuntimeKey {
    static let key_willAppearInjectBlockContainer
        = UnsafeRawPointer(bitPattern: "key_willAppearInjectBlockContainer".hashValue)
    static let key_interactivePopDisabled
        = UnsafeRawPointer(bitPattern: "key_interactivePopDisabled".hashValue)
    static let key_prefersNavigationBarHidden
        = UnsafeRawPointer(bitPattern: "key_prefersNavigationBarHidden".hashValue)
    static let key_interactivePopMaxAllowedInitialDistanceToLeftEdge
        = UnsafeRawPointer(bitPattern: "key_interactivePopMaxAllowedInitialDistanceToLeftEdge".hashValue)
    static let key_fullscreenPopGestureRecognizer
        = UnsafeRawPointer(bitPattern: "key_fullscreenPopGestureRecognizer".hashValue)
    static let key_popGestureRecognizerDelegate
        = UnsafeRawPointer(bitPattern: "key_popGestureRecognizerDelegate".hashValue)
    static let key_viewControllerBasedNavigationBarAppearanceEnabled
        = UnsafeRawPointer(bitPattern: "key_viewControllerBasedNavigationBarAppearanceEnabled".hashValue)
    static let key_scrollViewPopGestureRecognizerEnable
        = UnsafeRawPointer(bitPattern: "key_scrollViewPopGestureRecognizerEnable".hashValue)
}


fileprivate extension DispatchQueue {
    private static var _onceTracker = [String]()
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}



private class VGFullscreenPopGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    
    weak var navigationController: UINavigationController?
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard let navigationC = self.navigationController else {
            return false
        }
        
        // Ignore when no view controller is pushed into the navigation stack.
        guard navigationC.viewControllers.count > 1, let topViewController = navigationC.viewControllers.last else {
            return false
        }
        
        // Disable when the active view controller doesn't allow interactive pop.
        guard topViewController.vg_interactivePopDisabled == false else {
            return false
        }
        
        // Ignore pan gesture when the navigation controller is currently in transition.
        guard let trasition = navigationC.value(forKey: "_isTransitioning") as? Bool else {
            return false
        }
        
        guard trasition == false, let panGesture = gestureRecognizer as? UIPanGestureRecognizer else {
            return false
        }
        
        // Ignore when the beginning location is beyond max allowed initial distance to left edge.
        let beginningLocation = panGesture.location(in: panGesture.view)
        let maxAllowedInitialDistance = topViewController.vg_interactivePopMaxAllowedInitialDistanceToLeftEdge
        if maxAllowedInitialDistance > 0 && Double(beginningLocation.x) > maxAllowedInitialDistance {
            return false
        }
        
        // Prevent calling the handler when the gesture begins in an opposite direction.
        let translation = panGesture.translation(in: panGesture.view)
        guard translation.x > 0 else {
            return false
        }
        
        return true
    }
}




extension UIScrollView: UIGestureRecognizerDelegate {
    
    public var vg_scrollViewPopGestureRecognizerEnable: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.key_scrollViewPopGestureRecognizerEnable!) as? Bool else {
                return false
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.key_scrollViewPopGestureRecognizerEnable!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    //UIGestureRecognizerDelegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.vg_scrollViewPopGestureRecognizerEnable, self.contentOffset.x <= 0, let gestureDelegate = otherGestureRecognizer.delegate {
            if gestureDelegate.isKind(of: VGFullscreenPopGestureRecognizerDelegate.self) {
                return true
            }
        }
        return false
    }
}





fileprivate typealias VGViewControllerWillAppearInjectBlock = (_ viewController: UIViewController, _ animated: Bool) -> Void
fileprivate class VGViewControllerWillAppearInjectBlockContainer {
    var block: VGViewControllerWillAppearInjectBlock?
    init(_ block: @escaping VGViewControllerWillAppearInjectBlock) {
        self.block = block
    }
}

extension UIViewController {
    fileprivate var vg_willAppearInjectBlockContainer: VGViewControllerWillAppearInjectBlockContainer? {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.key_willAppearInjectBlockContainer!) as? VGViewControllerWillAppearInjectBlockContainer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.key_willAppearInjectBlockContainer!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public class func vg_initialize() {
        DispatchQueue.once(token: "com.UIViewController.MethodSwizzling", block: {
            let originalMethod = class_getInstanceMethod(self, #selector(viewWillAppear(_:)))
            let swizzledMethod = class_getInstanceMethod(self, #selector(vg_viewWillAppear(_:)))
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        })
    }
    
    @objc private func vg_viewWillAppear(_ animated: Bool) {
        // Forward to primary implementation.
        self.vg_viewWillAppear(animated)
        
        if let block = self.vg_willAppearInjectBlockContainer?.block {
            block(self, animated)
        }
    }
    
    /// Whether the interactive pop gesture is disabled when contained in a navigation stack.
    public var vg_interactivePopDisabled: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.key_interactivePopDisabled!) as? Bool else {
                return false
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.key_interactivePopDisabled!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// Indicate this view controller prefers its navigation bar hidden or not,
    /// checked when view controller based navigation bar's appearance is enabled.
    /// Default to false, bars are more likely to show.
    public var vg_prefersNavigationBarHidden: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.key_prefersNavigationBarHidden!) as? Bool else {
                return false
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.key_prefersNavigationBarHidden!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// Max allowed initial distance to left edge when you begin the interactive pop
    /// gesture. 0 by default, which means it will ignore this limit.
    public var vg_interactivePopMaxAllowedInitialDistanceToLeftEdge: Double {
        get {
            guard let doubleNum = objc_getAssociatedObject(self, RuntimeKey.key_interactivePopMaxAllowedInitialDistanceToLeftEdge!) as? Double else {
                return 0.0
            }
            return doubleNum
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.key_interactivePopMaxAllowedInitialDistanceToLeftEdge!, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
}





extension UINavigationController {

    private var vg_popGestureRecognizerDelegate: VGFullscreenPopGestureRecognizerDelegate {
        guard let delegate = objc_getAssociatedObject(self, RuntimeKey.key_popGestureRecognizerDelegate!) as? VGFullscreenPopGestureRecognizerDelegate else {
            let popDelegate = VGFullscreenPopGestureRecognizerDelegate()
            popDelegate.navigationController = self
            objc_setAssociatedObject(self, RuntimeKey.key_popGestureRecognizerDelegate!, popDelegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return popDelegate
        }
        return delegate
    }
    
    /// The gesture recognizer that actually handles interactive pop.
    public var vg_fullscreenPopGestureRecognizer: UIPanGestureRecognizer {
        guard let pan = objc_getAssociatedObject(self, RuntimeKey.key_fullscreenPopGestureRecognizer!) as? UIPanGestureRecognizer else {
            let panGesture = UIPanGestureRecognizer()
            panGesture.maximumNumberOfTouches = 1
            objc_setAssociatedObject(self, RuntimeKey.key_fullscreenPopGestureRecognizer!, panGesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return panGesture
        }
        return pan
    }
    
    /// A view controller is able to control navigation bar's appearance by itself,
    /// rather than a global way, checking "fd_prefersNavigationBarHidden" property.
    /// Default to true, disable it if you don't want so.
    public var vg_viewControllerBasedNavigationBarAppearanceEnabled: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.key_viewControllerBasedNavigationBarAppearanceEnabled!) as? Bool else {
                self.vg_viewControllerBasedNavigationBarAppearanceEnabled = true
                return true
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.key_viewControllerBasedNavigationBarAppearanceEnabled!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    @objc private func vg_pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.interactivePopGestureRecognizer?.view?.gestureRecognizers?.contains(self.vg_fullscreenPopGestureRecognizer) == false {
            // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
            self.interactivePopGestureRecognizer?.view?.addGestureRecognizer(self.vg_fullscreenPopGestureRecognizer)
            // Forward the gesture events to the private handler of the onboard gesture recognizer.
            let internalTargets = self.interactivePopGestureRecognizer?.value(forKey: "targets") as? Array<NSObject>
            let internalTarget = internalTargets?.first?.value(forKey: "target")
            let internalAction = NSSelectorFromString("handleNavigationTransition:")
            if let target = internalTarget {
                self.vg_fullscreenPopGestureRecognizer.delegate = self.vg_popGestureRecognizerDelegate
                self.vg_fullscreenPopGestureRecognizer.addTarget(target, action: internalAction)
                // Disable the onboard gesture recognizer.
                self.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        // Handle perferred navigation bar appearance.
        self.vg_setupViewControllerBasedNavigationBarAppearanceIfNeeded(viewController)
        // Forward to primary implementation.
        self.vg_pushViewController(viewController, animated: animated)
    }
    
    private func vg_setupViewControllerBasedNavigationBarAppearanceIfNeeded(_ appearingViewController: UIViewController) {
        if !self.vg_viewControllerBasedNavigationBarAppearanceEnabled {
            return
        }
        let blockContainer = VGViewControllerWillAppearInjectBlockContainer() { [weak self] (_ viewController: UIViewController, _ animated: Bool) -> Void in
            self?.setNavigationBarHidden(viewController.vg_prefersNavigationBarHidden, animated: animated)
        }
        // Setup will appear inject block to appearing view controller.
        // Setup disappearing view controller as well, because not every view controller is added into
        // stack by pushing, maybe by "-setViewControllers:".
        appearingViewController.vg_willAppearInjectBlockContainer = blockContainer
        let disappearingViewController = self.viewControllers.last
        if let vc = disappearingViewController {
            if vc.vg_willAppearInjectBlockContainer == nil {
                vc.vg_willAppearInjectBlockContainer = blockContainer
            }
        }
    }
    
    public class func vg_nav_initialize() {
        // Inject "-pushViewController:animated:"
        DispatchQueue.once(token: "com.UINavigationController.MethodSwizzling", block: {
            let originalMethod = class_getInstanceMethod(self, #selector(pushViewController(_:animated:)))
            let swizzledMethod = class_getInstanceMethod(self, #selector(vg_pushViewController(_:animated:)))
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        })
    }
    
}


open class VGFullscreenPopGesture {
    open class func configure() {
        UINavigationController.vg_nav_initialize()
        UIViewController.vg_initialize()
    }
}
