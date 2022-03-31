

import UIKit


extension ToDoListViewController : UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("---textFieldShouldReturn")
        if keyboardIsUp{
            
   
        toolBar.frame = CGRect(x: toolBar.frame.minX , y: toolBar.frame.minY + keyboardHeight  , width: toolBar.frame.width , height: toolBar.frame.height )
            keyboardIsUp = false
        }
        textField.resignFirstResponder() //要求離開我們的Responder
        return true
    }
    

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if keyboardIsUp{
        toolBar.frame = CGRect(x: toolBar.frame.minX , y: toolBar.frame.minY + keyboardHeight  , width: toolBar.frame.width , height: toolBar.frame.height )
            keyboardIsUp = false
        }
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("---keyboardWillShow")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
              keyboardHeight = keyboardRectangle.height
           
            if !keyboardIsUp{
              // toolBar.frame.minY - keyboardHeight
            toolBar.frame = CGRect(x: toolBar.frame.minX , y:  keyboardRectangle.minY - toolBar.frame.height , width: toolBar.frame.width , height: toolBar.frame.height )
                
                
                keyboardIsUp = true
                
            }
        }
    }
    
    
}
