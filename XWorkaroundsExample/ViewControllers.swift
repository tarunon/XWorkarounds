//
//  ViewController.swift
//  XWorkaroundsExample
//
//  Created by tarunon on 2017/10/24.
//  Copyright © 2017 tarunon. All rights reserved.
//

import UIKit
import XWorkarounds

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func launchCommonFullscreenViewController(_ sender: Any) {
        present(CommonFullscreenViewController(), animated: true)
    }

    @IBAction func launchWorkaroundFullscreenViewController(_ sender: Any) {
        present(WorkaroundFullscreenViewController(with: CommonFullscreenViewController()), animated: true)
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pop(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

class SafeAreaVisibleViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)
        let centerView = UIView()
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        let topLabel = UILabel()
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.text = "Top"
        topLabel.font = .systemFont(ofSize: 40.0)
        let bottomLabel = UILabel()
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.text = "Bottom"
        bottomLabel.font = .systemFont(ofSize: 40.0)
        view.insertSubview(centerView, at: 0)
        view.insertSubview(topView, at: 1)
        view.insertSubview(bottomView, at: 2)
        view.insertSubview(topLabel, at: 3)
        view.insertSubview(bottomLabel, at: 4)
        NSLayoutConstraint.activate(
            [
                centerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                centerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                centerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                centerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                topView.topAnchor.constraint(equalTo: view.topAnchor),
                topView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                topView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                topView.bottomAnchor.constraint(equalTo: centerView.topAnchor),
                bottomView.topAnchor.constraint(equalTo: centerView.bottomAnchor),
                bottomView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                bottomView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                topLabel.topAnchor.constraint(equalTo: centerView.topAnchor),
                topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                bottomLabel.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
                bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
}


class CommonFullscreenViewController: SafeAreaVisibleViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissButton = UIButton(type: .system)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate(
            [
                dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
        dismissButton.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
    }
}

class WorkaroundFullscreenViewController: FullscreenViewController<CommonFullscreenViewController> {
    
}

class PushWithHideTabBarNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

class PushWithHideTabBarViewController: SafeAreaVisibleViewController {
    @IBInspectable var shouldTabBarHidden: Bool = false {
        didSet {
            (tabBarController as? TabBarController)?.setTabBarHidden(shouldTabBarHidden, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarController)?.setTabBarHidden(shouldTabBarHidden, animated: animated)
    }

    @IBAction func switchTabBarHidden(_ sender: UISwitch) {
        shouldTabBarHidden = !sender.isOn
    }
}
