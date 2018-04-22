//
//  Welcome.swift
//  Route
//
//  Created by Ramesh Siddanavar on 3/16/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit
import Foundation

struct Constants {
    
    static let notchWidth: CGFloat = 209
    static let notchHeight: CGFloat = 26
    static let maxScrollOffset: CGFloat = -86
    static let notchViewTopInset: CGFloat = 40
}

extension NSLayoutConstraint {
    
    func activate() {
        NSLayoutConstraint.activate([self])
    }
    
    func deactivate() {
        NSLayoutConstraint.deactivate([self])
    }
    
}

extension UIImage {
    
    static func fromColor(_ color: UIColor) -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIView {
    func snapshotImage(afterScreenUpdated: Bool = true) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { _ in
            self.drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdated)
        }
    }
}

//@IBDesignable
//final class CardVieww: UIView {
////    @IBInspectable var startColor: UIColor = UIColor.init(red: 220.0 / 255.0, green: 109.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
// //   @IBInspectable var endColor: UIColor = UIColor.init(red: 217.0 / 255.0, green: 68.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0)
//
//    override func draw(_ rect: CGRect) {
////        let gradient: CAGradientLayer = CAGradientLayer()
////        gradient.frame = CGRect(x: CGFloat(0),
////                                y: CGFloat(0),
////                                width: superview!.frame.size.width,
////                                height: superview!.frame.size.height)
////        gradient.colors = [startColor.cgColor, endColor.cgColor]
////        gradient.zPosition = -1
////        //   gradient.locations = [0.5, 0, 0.5, 0]
////        layer.addSublayer(gradient)
//
//        superview!.translatesAutoresizingMaskIntoConstraints = false
//        superview!.backgroundColor = UIColor.white
//      //  superview!.layer.cornerRadius = 2
//        superview!.layer.masksToBounds = false
//
//
//        superview!.layer.shadowOpacity = 0.6
//     //   superview!.layer.shadowColor =  UIColor.gray //   (UIColor.lightGray as! CGColor)
//        superview!.layer.shadowOffset = CGSize.zero
//        superview!.layer.shadowRadius = 14
//        superview!.layer.cornerRadius = 20
//
////        superview!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).activate()
////        superview!.widthAnchor.constraint(equalToConstant: Constants.notchWidth).activate()
////        superview!.heightAnchor.constraint(equalToConstant: 200).activate()
////        notchViewBottomConstraint = notchView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.notchHeight)
////        notchViewBottomConstraint.activate()
//
//    }
//}
//



class Welcome: UIViewController {

 //   @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: Fileprivates
    
    fileprivate var notchView = UIView()
    fileprivate var notchViewBottomConstraint: NSLayoutConstraint!
    fileprivate var isPulling: Bool = false
    fileprivate var numberOfItemsInSection = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureNotchView()
        self.collectionView.alwaysBounceVertical = true
    }
    
    private func configureNotchView() {
        self.view.addSubview(notchView)
        
        notchView.translatesAutoresizingMaskIntoConstraints = false
        notchView.backgroundColor = UIColor.clear
        notchView.layer.cornerRadius = 2
        notchView.layer.masksToBounds = false
        
        notchView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).activate()
        notchView.widthAnchor.constraint(equalToConstant: Constants.notchWidth).activate()
        notchView.heightAnchor.constraint(equalToConstant: 200).activate()
        notchViewBottomConstraint = notchView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.notchHeight)
        notchViewBottomConstraint.activate()
    }
    
    private func animateView() {
        let animatableView = UIImageView(frame: notchView.frame)
        animatableView.backgroundColor = UIColor.black
        animatableView.layer.cornerRadius = self.notchView.layer.cornerRadius
        animatableView.layer.masksToBounds = true
        animatableView.frame = self.notchView.frame
        self.view.addSubview(animatableView)
        
        notchViewBottomConstraint.constant = Constants.notchHeight
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let height = flowLayout.itemSize.height + flowLayout.minimumInteritemSpacing
        
        self.collectionView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -Constants.maxScrollOffset)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            let itemSize = flowLayout.itemSize
            animatableView.frame.size = CGSize(width: Constants.notchWidth, height: (itemSize.height / itemSize.width) * Constants.notchWidth)
            animatableView.image = UIImage.fromColor(self.view.backgroundColor?.withAlphaComponent(0.2) ?? UIColor.black)
            animatableView.frame.origin.y = Constants.notchViewTopInset
            self.collectionView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: height * 0.5)
        }) { _ in
            let item = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0))
            animatableView.image = item?.snapshotImage()
            
            UIView.transition(with: animatableView, duration: 0.6, options: UIViewAnimationOptions.transitionFlipFromBottom, animations: {
                animatableView.frame.size = flowLayout.itemSize
                animatableView.frame.origin = CGPoint(x: (self.collectionView.frame.width - flowLayout.itemSize.width) / 2.0,
                                                      y: self.collectionView.frame.origin.y - height * 0.5)
                self.collectionView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: height)
            }, completion: { _ in
                self.collectionView.transform = CGAffineTransform.identity
                animatableView.removeFromSuperview()
                self.isPulling = false
                self.numberOfItemsInSection += 1
                self.collectionView.reloadData()
            }
            )
        }
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.fromValue = 16
        cornerRadiusAnimation.toValue = 10
        cornerRadiusAnimation.duration = 0.3
        animatableView.layer.add(cornerRadiusAnimation, forKey: "cornerRadius")
        animatableView.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Welcome: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension Welcome: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = max(Constants.maxScrollOffset, scrollView.contentOffset.y)
        notchViewBottomConstraint.constant = Constants.notchHeight - min(0, scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y <= Constants.maxScrollOffset {
            animateView()
        }
    }
}
/*
extension Welcome : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Aspect Ratio of 5:6 is preferred
//        let card = CardHighlight(frame: CGRect(x: 10, y: 30, width: 300 , height: 200))
//        
//        card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
//        card.icon = UIImage(named: "iOS")
//        card.title = "Welcome \nto \nFootRoute !"
//        card.itemTitle = "Travel Made Easy"
//        card.itemSubtitle = "Getting Started..."
//        card.textColor = UIColor.white
//        
//        card.hasParallax = true
//        
//        //   let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContentt")
//        //   card.shouldPresent(cardContentVC, from: self, fullscreen: false)
//        
//        //     view.addSubview(card)
//        cell.contentView.addSubview(card)
//        //  cell.contentView.sizeThatFits(CGSize.init(width: 300, height: 200))
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
        
        return cell
    }
    
}

extension Welcome : UITableViewDelegate {
    
    
}
*/
