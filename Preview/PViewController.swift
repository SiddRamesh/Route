//  Created by Ramesh Siddanavar on 3/16/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit

class PViewController: UIViewController {

    @IBOutlet var skipButton: UIButton!

    fileprivate let items = [
        OnboardingItemInfo(informationImage: Asset.hotels.image,
                           title: "Hotels",
                           description: "All hotels and hostels are sorted by hospitality rating",
                           pageIcon: Asset.key.image,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.banks.image,
                           title: "Banks",
                           description: "We carefully verify all banks before add them into the app",
                           pageIcon: Asset.wallet.image,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.stores.image,
                           title: "Stores",
                           description: "All local stores are categorized for your convenience",
                           pageIcon: Asset.shoppingCart.image,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.key.image,
                           title: "Keys",
                           description: "Secure ur Accont with OTP",
                           pageIcon: Asset.key.image,
                           color: UIColor(red: 0.11, green: 0.67, blue: 0.54, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.wallet.image,
                           title: "Wallets",
                           description: "Share ur Expenses",
                           pageIcon: Asset.wallet.image,
                           color: UIColor(red: 0.22, green: 0.68, blue: 0.34, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.profile.image,
                           title: "Friends",
                           description: "Get Along with ur Buddies",
                           pageIcon: Asset.pprofile.image,
                           color: UIColor(red: 0.85, green: 0.25, blue: 0.40, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.activity.image,
                           title: "Share",
                           description: "Because, Sharing is Caring :)",
                           pageIcon: Asset.activity.image,
                           color: UIColor(red: 0.25, green: 0.46, blue: 0.84, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = false

        setupPaperOnboardingView()

        view.bringSubview(toFront: skipButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // Add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
}

// MARK: Actions

extension PViewController {

    @IBAction func skipButtonTapped(_: UIButton) {
        print(#function)
    }
}

// MARK: PaperOnboardingDelegate

extension PViewController: PaperOnboardingDelegate {

    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.setTitle("Done", for: .normal)
        skipButton.isHidden = index == 6 ? false : true
    }

    func onboardingDidTransitonToIndex(_ index: Int) {
      //  skipButton.setTitle("Done", for: .normal)
      //  skipButton.isHidden = index == 6 ? false : true
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource

extension PViewController: PaperOnboardingDataSource {

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 7
    }

    //  func onboardingPageItemColor(at index: Int) -> UIColor {
//    return [UIColor.white, UIColor.red, UIColor.green][index]
    //  }
}


//MARK: Constants
extension PViewController {
    
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    private static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}

