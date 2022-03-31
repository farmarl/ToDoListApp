

import UIKit


extension ToDoListViewController{
    
    func fakeDelay( complite : DoneHandler?  ){
        print("What's happen?")
        self.spinner.startAnimating()
        
        //上鎖
        self.textField.isEnabled = false
        self.sendButton.titleLabel?.text = "Loading"
        self.sendButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3 ) {
            print("Async after 2 seconds")
            self.spinner.stopAnimating()
            //解鎖
            self.textField.isEnabled = true
            self.sendButton.titleLabel?.text = "送出"
            self.sendButton.isEnabled = true
            
            
            guard let complite = complite else{return}
            complite(nil)
        }
       
        
    }
    
    
}
