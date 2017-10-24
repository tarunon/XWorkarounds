//
//  TabBarController.swift
//  XWorkarounds
//
//  Created by tarunon on 2017/10/24.
//  Copyright © 2017 tarunon. All rights reserved.
//

open class TabBarController: UITabBarController {
    private var _isTabBarHidden: Bool = false
    private var _hiddenTabBar: HiddenTabBar!

    open var isTabBarHidden: Bool {
        set {
            setTabBarHidden(newValue, animated: false)
        }
        get {
            return _isTabBarHidden
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        _hiddenTabBar = HiddenTabBar()
        _hiddenTabBar.frame = tabBar.frame
        view.addSubview(_hiddenTabBar)
        _hiddenTabBar.isHidden = true
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarMinY(_isTabBarHidden)
    }

    open func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        if _isTabBarHidden == hidden { return }
        _isTabBarHidden = hidden

        _hiddenTabBar.isHidden = false

        UIView.animate(
            withDuration: animated ? TimeInterval(UINavigationControllerHideShowBarDuration) : 0.0,
            animations: {
                self.updateTabBarMinY(hidden)
                self.tabBar.isHidden = hidden
                self.additionalSafeAreaInsets.bottom += 1.0
                self.additionalSafeAreaInsets.bottom -= 1.0
                self.view.layoutIfNeeded()
            }, completion: { _ in
                if self.tabBar.frame.minY == self.expectedTabBarMinY(hidden) {
                    self._hiddenTabBar.isHidden = !hidden
                } else {
                    self._hiddenTabBar.isHidden = hidden
                    self.tabBar.isHidden = !hidden
                    self._isTabBarHidden = !hidden
                }
                self.view.layoutIfNeeded()
            }
        )
    }

    private func expectedTabBarMinY(_ hidden: Bool) -> CGFloat {
        if hidden {
            return view.bounds.height - view.safeAreaInsets.bottom
        } else {
            return view.bounds.height - tabBar.bounds.height
        }
    }

    private func updateTabBarMinY(_ hidden: Bool) {
        tabBar.frame.origin.y = expectedTabBarMinY(hidden)
        _hiddenTabBar.frame = tabBar.frame
    }

    class HiddenTabBar: UITabBar {

    }
}
