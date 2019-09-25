//
//  LoaderButton.swift
//  Baqala
//
//  Created by apple on 2/28/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit


class LoaderButton: UIButton {
    var originalButtonText: String?
    var originalButtonImage: UIImage?
    var orginalBackgroundColor: UIColor?
    
    var activityIndicator: UIActivityIndicatorView!
    // bloack UI
    func showLoading(view: UIView) {
        originalButtonText = self.titleLabel?.text
        originalButtonImage = self.currentImage
        orginalBackgroundColor = self.backgroundColor
        
        self.setTitle("", for: .normal)
        self.setImage(nil, for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.9710801244, green: 0.6898229718, blue: 0.2214611471, alpha: 1)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
       
        showSpinning()
        view.isUserInteractionEnabled = false
    }
    
    func hideLoading(view: UIView) {
        self.setTitle(originalButtonText, for: .normal)
        self.setImage(originalButtonImage, for: .normal)
        self.backgroundColor = orginalBackgroundColor
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    //Load without blocking UI
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        originalButtonImage = self.currentImage
        orginalBackgroundColor = self.backgroundColor
        
        self.setTitle("", for: .normal)
        self.setImage(nil, for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.9710801244, green: 0.6898229718, blue: 0.2214611471, alpha: 1)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
       
    }
   
    
    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        self.setImage(originalButtonImage, for: .normal)
        self.backgroundColor = orginalBackgroundColor
        activityIndicator.stopAnimating()
      
    }
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}



class ActivityIndicator {
    private init() {}
    
    //1
    static let shared = ActivityIndicator()
    
    //2
    let activityLabel = UILabel(frame: CGRect(x: 24, y: 0, width: 0, height: 0))
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let activityView = UIView()
    
    func animateActivity(title: String, view: UIView, navigationItem: UINavigationItem) {
        //3
        guard navigationItem.titleView == nil else { return }
        
        //4
        activityIndicator.style = .gray
        activityLabel.text = title
        
        //5
        activityLabel.sizeToFit()
        
        //6
        let xPoint = view.frame.midX
        let yPoint = navigationItem.accessibilityFrame.midY
        let widthForActivityView = activityLabel.frame.width + activityIndicator.frame.width
        activityView.frame = CGRect(x: xPoint, y: yPoint, width: widthForActivityView, height: 30)
        
        activityLabel.center.y = activityView.center.y
        activityIndicator.center.y = activityView.center.y
        
        //7
        activityView.addSubview(activityIndicator)
        activityView.addSubview(activityLabel)
        
        //8
        navigationItem.titleView = activityView
        activityIndicator.startAnimating()
    }
    
    //9
    func stopAnimating(navigationItem: UINavigationItem) {
        activityIndicator.stopAnimating()
        navigationItem.titleView = nil
    }
}
