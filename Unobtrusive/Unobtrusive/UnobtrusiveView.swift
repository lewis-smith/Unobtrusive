//
//  UnobtrusiveView.swift
//  UnobtrusivePrompt
//
//  Created by Lewis Smith on 18/01/2017.
//  Copyright © 2017 Lewis Makes Apps. All rights reserved.
//


import UIKit

@IBDesignable

public class UnobtrusiveView: UIView {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet public weak var label: UILabel!
    @IBOutlet public weak var button: UIButton!
    var contentView : UIView?
    
    public var tapGoCallback : (() -> Void)?
    public var tapCloseCallback : (() -> Void)?
    
    override public var backgroundColor: UIColor? {
        didSet {
            self.contentView?.backgroundColor = backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        hide()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
    }
    
    public override func prepareForInterfaceBuilder() {
        setLabelText(text: "call .setLabelText(\"to set this text\")")
    }
    
    private func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    public func hide() {
        self.button.isHidden = true
        self.label.text = ""
        self.label.isHidden = true
        self.bottomConstraint.constant = 0
        self.topConstraint.constant = 0
    }
    
    public func show() {
        self.button.isHidden = false
        self.label.isHidden = false
        self.bottomConstraint.constant = 8
        self.topConstraint.constant = 8
    }
    
    public func setLabelText(text: String) {
        show()
        self.label.text = text
    }
    
    @IBAction func goButtonTapped(_ sender: Any) {
        self.tapGoCallback!();
    }
    
    @IBAction func notificationTapped(_ sender: Any) {
        self.superview?.layoutIfNeeded()
        
        self.label.text = ""
        self.topConstraint.constant = 0
        self.bottomConstraint.constant = 0
        self.button.isHidden = true
        
        UIView.animate(withDuration: 0.125, animations: {
            self.superview?.layoutIfNeeded()
        }) { (finished: Bool) in
            if finished {
                if (self.tapCloseCallback != nil) {
                    self.tapCloseCallback!();
                }
            }
        }
        
        
    }
}
