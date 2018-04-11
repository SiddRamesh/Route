//  Created by Ramesh Siddanavar on 14/03/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit

public class DemoDetailViewController: PTDetailViewController {

    @IBOutlet var controlBottomConstrant: NSLayoutConstraint!

    // bottom control icons
    @IBOutlet var controlsViewContainer: UIView!
    @IBOutlet var controlView: UIView!
    @IBOutlet var plusImageView: UIImageView!
    @IBOutlet var controlTextLabel: UILabel!
    @IBOutlet var controlTextLableLending: NSLayoutConstraint!
    @IBOutlet var shareImageView: UIImageView!
    @IBOutlet var hertIconView: UIImageView!

    var backButton: UIButton?

    var bottomSafeArea: CGFloat {
        var result: CGFloat = 0
        if #available(iOS 11.0, *) {
            result = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return result
    }
}

// MARK: life cicle
extension DemoDetailViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        backButton = createBackButton()
        _ = createNavigationBarBackItem(button: backButton)

        // animations
        showBackButtonDuration(duration: 0.3)
        showControlViewDuration(duration: 0.3)

        _ = createBlurView()
    }
}

// MARK: helpers
extension DemoDetailViewController {

    fileprivate func createBackButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 44))
        button.setImage(UIImage.Asset.Back.image, for: .normal)
        button.addTarget(self, action: #selector(DemoDetailViewController.backButtonHandler), for: .touchUpInside)
        return button
    }

    fileprivate func createNavigationBarBackItem(button: UIButton?) -> UIBarButtonItem? {
        guard let button = button else {
            return nil
        }

        let buttonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = buttonItem
        return buttonItem
    }

    fileprivate func createBlurView() -> UIView {
        let height = controlView.bounds.height + bottomSafeArea
        let imageFrame = CGRect(x: 0, y: view.frame.size.height - height, width: view.frame.width, height: height)
        let image = view.makeScreenShotFromFrame(frame: imageFrame)
        let screnShotImageView = UIImageView(image: image)
        screnShotImageView.blurViewValue(value: 5)
        screnShotImageView.frame = controlsViewContainer.bounds
        screnShotImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controlsViewContainer.insertSubview(screnShotImageView, at: 0)
        addOverlay(toView: screnShotImageView)
        return screnShotImageView
    }

    fileprivate func addOverlay(toView view: UIView) {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = .black
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView.alpha = 0.4
        view.addSubview(overlayView)
    }
}

// MARK: animations
extension DemoDetailViewController {

    fileprivate func showBackButtonDuration(duration: Double) {
        backButton?.rotateDuration(duration: duration, from: -CGFloat.pi / 4, to: 0)
        backButton?.scaleDuration(duration: duration, from: 0.5, to: 1)
        backButton?.opacityDuration(duration: duration, from: 0, to: 1)
    }

    fileprivate func showControlViewDuration(duration: Double) {
        moveUpControllerDuration(duration: duration)
        showControlButtonsDuration(duration: duration)
        showControlLabelDuration(duration: duration)
    }

    fileprivate func moveUpControllerDuration(duration: Double) {

        controlBottomConstrant.constant = -controlsViewContainer.bounds.height
        view.layoutIfNeeded()

        controlBottomConstrant.constant = 0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    fileprivate func showControlButtonsDuration(duration: Double) {
        [plusImageView, shareImageView, hertIconView].forEach {
            $0?.rotateDuration(duration: duration, from: CGFloat.pi / 4, to: 0, delay: duration)
            $0?.scaleDuration(duration: duration, from: 0.5, to: 1, delay: duration)
            $0?.alpha = 0
            $0?.opacityDuration(duration: duration, from: 0, to: 1, delay: duration, remove: false)
        }
    }

    fileprivate func showControlLabelDuration(duration: Double) {
        controlTextLabel.alpha = 0
        controlTextLabel.opacityDuration(duration: duration, from: 0, to: 1, delay: duration, remove: false)

        // move rigth
        let offSet: CGFloat = 20
        controlTextLableLending.constant -= offSet
        view.layoutIfNeeded()

        controlTextLableLending.constant += offSet
        UIView.animate(withDuration: duration * 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: actions
extension DemoDetailViewController {

    @objc func backButtonHandler() {
        popViewController()
    }
}
