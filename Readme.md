# XWorkarounds

Workarounds for iPhoneX/iOS11

## 1. Fullscreen Modal
![](https://github.com/tarunon/XWorkarounds/blob/master/Readme/fullscreen_modal.gif)
Long time we know that Fullscreen Modal ViewController broken parent and self layout when come from NavigationController.
iPhoneX fixed, but we will suffer that behavior in iPhone8(or below).
FullscreenViewController fix it, and support call statusbar also.
Usage
```swift
let vc = FullscreenViewController(with: MyFullscreenViewController())
```

## 2. TabBarController's tabBar hidden
![](https://github.com/tarunon/XWorkarounds/blob/master/Readme/tabbar_hidden.gif)
Adding `UITabBarController.setTabBarHidden(_:animated:)`, and full fix support safearea.
The TabBarController work well in iPhoneX also, please try out!
