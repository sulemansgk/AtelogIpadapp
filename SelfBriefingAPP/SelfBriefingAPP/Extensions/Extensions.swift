//
//  File.swift
//  SelfBriefingAPP
//
//  Created by AliSons  on 20/08/2019.
//  Copyright © 2019 AliSons . All rights reserved.
//
//


import UIKit

import Foundation
extension UILabel{
    // Attributed text for Bold and Regular text in one UILabel Ref Stackoverflow
    func setBoldAndRegularTitle(boldString:String , regularString : String , boldFontSize:Int , regularFontSize:Int) {
        //Code sets label (yourLabel)'s text to "Tap and hold(BOLD) button to start recording."
        let boldAttribute = [
            //You can add as many attributes as you want here.
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: CGFloat(boldFontSize))!]//14
        
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: CGFloat(regularFontSize))!]//12
        
        let boldAttributedString = NSAttributedString(string:  boldString, attributes: boldAttribute)
        let endAttributedString = NSAttributedString(string: regularString, attributes: regularAttribute )
        let fullString =  NSMutableAttributedString()
        
        fullString.append(boldAttributedString)
        fullString.append(endAttributedString)
        
        self.attributedText = fullString
    }
}


extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y-200,width: 1,height: self.frame.height), animated: animated)
        }
    }
    
    //Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    //Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}
extension UIViewController {
    
    typealias Func = () -> Void
    // Quick Alert box with 2 Actions
    func showMessage(title:String , message:String ,doneButtonText:String?,cancelButtonText:String? , done:Func? , cancel : Func?) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if let textDone =  doneButtonText {
            alert.addAction(UIAlertAction(title: textDone, style: UIAlertAction.Style.default, handler: { action in
                if let fun = done{
                    fun();
                }
            }))
        }
        
        if let textCancel = cancelButtonText{
            alert.addAction(UIAlertAction(title: textCancel, style: UIAlertAction.Style.cancel, handler: {action in
                if let fun = cancel{
                    fun();
                }
            }))
        }
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // Specially used in User Profile
    // because there is no done or submit button on the keyboard of numerical type
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlertSheetWith(actions : [UIAlertAction] , title:String , message:String)  {
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet);
        for action in actions{
            sheet.addAction(action);
        }
        self.present(sheet, animated: true, completion: nil)
    }
}

extension UIImageView {
    // Quick shadow for imageView
    func applyListingShadow()  {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
    }
    
    func applyRoundImage()  {
        print("Round Image")
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        let w = self.bounds.width/2
        print("Width \(w)")
        //self.layer.shadowRadius = w
        self.layer.cornerRadius = 10
    }
    
    
}
extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSinceReferenceDate * 1000))
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSinceReferenceDate: TimeInterval(milliseconds / 1000))
    }
}
