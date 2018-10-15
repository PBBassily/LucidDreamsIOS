//
//  InputTableViewCell.swift
//  LucidDreams
//
//  Created by Paula Boules on 10/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet private weak var inputTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputTextField.delegate = self
        
        initToolBarForKeyBoard()
        
        
    }
    
    public func  configure(text: String?){
        inputTextField.text = text
    }
    
    public func addEditingChangedListener(target : Any? ,selector: Selector){
        inputTextField.addTarget(target , action: selector, for: UIControlEvents.editingChanged)
    }
    
    public func setNumberPadOnly(){
        inputTextField.keyboardType =  .asciiCapableNumberPad
    }
    private func initToolBarForKeyBoard() {
        
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneEditingButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        self.inputTextField.inputAccessoryView = toolbar
    }
    
    
    @objc private func doneEditingButtonAction() {
        
        inputTextField.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
}
