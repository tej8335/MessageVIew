//
//  PBMessageView.swift
//  PBToastView
//
//  Created by Tej on 23/10/18.
//  Copyright © 2018 Peerbits. All rights reserved.
//

import UIKit

public class PBMessageView: UIView {
    
    var messageView = UIView()
    var mainViewHeight:CGFloat = 0.0
    var mainViewTop:CGFloat = 0.0
    var backColor = UIColor()
    var iPhoneX = false
    var screenSizeHeight : CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- show only text -
    public  init(frame:CGRect,messageType:MessageType,message:String,direction:Direction) {
        super.init(frame: frame)
        self.layer.masksToBounds = false
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        mainViewHeight = 60
        screenSizeHeight = frame.height
        if Direction.Top == direction
        {
            mainViewTop = 20
            self.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 0)
            self.layer.shadowOffset = CGSize(width: -5, height: -5)
        }
        else
        {
            mainViewTop = 15
            self.frame = CGRect(x: 0, y: frame.origin.y + screenSizeHeight, width: frame.size.width, height: 0)
            self.layer.shadowOffset = CGSize(width: -5, height: 5)
        }
        if MessageType.Error == messageType
        {
            self.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        }
        else if MessageType.Warning == messageType
        {
            self.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
        }
        else
        {
            self.backgroundColor = UIColor.green.withAlphaComponent(0.7)
        }
        let lblMessage = UILabel()
        lblMessage.frame = CGRect(x: 20, y: 0, width: self.frame.size.width - 20, height: 30)
        lblMessage.text = message
        lblMessage.isUserInteractionEnabled = true
        lblMessage.font = UIFont.boldSystemFont(ofSize: 16)
        lblMessage.textColor = UIColor.white
        lblMessage.textAlignment = .center
        lblMessage.lineBreakMode = .byWordWrapping
        lblMessage.numberOfLines = 0
        lblMessage.sizeToFit()
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(.easeIn)
        UIView.setAnimationDuration(0.2)
        let height = self.heightForView(text: lblMessage.text!,font: lblMessage.font, width: lblMessage.frame.size.width)
        if #available(iOS 11.0, *) {
            if let mainWindow = (UIApplication.shared.delegate?.window)!{
                if (mainWindow.safeAreaInsets.top ) > 0.0 {
                    iPhoneX = true
                    mainViewTop = mainWindow.safeAreaInsets.top - 8
                    mainViewHeight = 75
                }
            }
        }
        
        if height > 30.0
        {
            let mainHeight = mainViewHeight - 30
            mainViewHeight = mainHeight + height
        }
        
        if Direction.Top == direction
        {
            self.frame = CGRect(x: 0, y: frame.origin.y, width: frame.size.width, height: self.mainViewHeight)
            lblMessage.frame = CGRect(x: 0, y: mainViewTop, width: self.frame.size.width, height: height)
        }
        else
        {
            self.frame = CGRect(x: 0, y:screenSizeHeight - mainViewHeight , width: frame.size.width, height: self.mainViewHeight)
            lblMessage.frame = CGRect(x: 0, y: height > 30 ? 10 : 20, width: self.frame.size.width, height: height)
        }
        UIView.commitAnimations()
        self.addSubview(lblMessage)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.addGestureRecognizer(tapGesture)
        self.perform(#selector(dismiss), with: nil, afterDelay: 2.0)
    }
    
   
    
    //MARK:- Dismiss NotificationBar -
    @objc func dismiss()
    {
        UIView.animate(withDuration: 0.3, delay: 0, options: self.frame.origin.y == 0.0 ? .transitionCurlUp : .transitionCurlDown, animations: {
            //set frame to hide view
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y == 0.0 ? self.frame.origin.y : (self.frame.origin.y) + (self.frame.size.height)  , width: self.frame.size.width, height: 0)
        }, completion: { (success) in
            if success
            {
                self.removeFromSuperview()
            }
        })
        
    }
    
    //MARK:- Show NotificationBar -
    public func showMessage(messageType:MessageType,_ message:String , view : UIView, direction : Direction)
    {
        //let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
        var statusBarMessageView = PBMessageView()
        statusBarMessageView = PBMessageView(frame: view.frame, messageType: messageType, message: message,direction: direction)
        view.addSubview(statusBarMessageView)
        view.layoutIfNeeded()
        view.layoutSubviews()
    }
    
    //MARK:- calculate height -
    private func heightForView(text:String,font:UIFont,width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
}

//MARK:- Message(Success,Error,Warning) Type -
public enum MessageType {
    case Success
    case Error
    case Warning
}

//MARK:- Message (Image,text) Type -
public enum ViewType {
    case Image
    case text
}

//MARK:- show view (Top,Bottom) -
public enum Direction{
    case Top
    case Bottom
}

