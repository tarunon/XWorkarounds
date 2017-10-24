//
//  FullscreenMoadlViewController.swift
//  XWorkarounds
//
//  Created by tarunon on 2017/10/24.
//  Copyright © 2017 tarunon. All rights reserved.
//

open class FullscreenViewController<ChildViewController: UIViewController>: UIViewController {
    public let childViewController: ChildViewController

    private var childViewControllerConstraints = [NSLayoutConstraint]()

    public init(with childViewController: ChildViewController) {
        self.childViewController = childViewController
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var isStatusBarHidden: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
            updateChildViewConstraint()
            updateSafeArea()
        }
    }

    private func setStatusBarHidden(_ hidden: Bool, animated: Bool) {
        if animated {
            UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration)) {
                self.isStatusBarHidden = hidden
                self.view.layoutIfNeeded()
            }
        } else {
            isStatusBarHidden = hidden
            view.layoutIfNeeded()
        }
    }

    private func updateChildViewConstraint() {
        NSLayoutConstraint.deactivate(childViewControllerConstraints)

        // Notes: choose (iPhone X top of safearea) or (iPhone 8 or below bottom of status bar)
        // view.frame.minY is workaround of call statusbar
        childViewControllerConstraints = [
            childViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.minY),
            childViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(childViewControllerConstraints)
    }

    private func updateSafeArea() {
        if UIApplication.shared.windows.first?.safeAreaInsets == UIEdgeInsets.zero {
            additionalSafeAreaInsets.top = -20.0
        }
    }

    open override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden || super.prefersStatusBarHidden
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        addChildViewController(childViewController)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childViewController.view)
        updateChildViewConstraint()
        childViewController.didMove(toParentViewController: self)
        view.layoutIfNeeded()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStatusBarHidden(false, animated: animated)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setStatusBarHidden(true, animated: animated)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setStatusBarHidden(false, animated: animated)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setStatusBarHidden(false, animated: animated)
    }
}
