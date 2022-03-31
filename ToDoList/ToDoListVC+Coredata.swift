

import UIKit

import CoreData


extension ToDoListViewController{
    
    
    
    func newOne(){
        
        // 1.寫入到coredata
        
        IDUS.shared.addOne(textString: self.textField.text ?? "n/a") { error in
            // 2.寫到todolist
                //新增完畢後查詢資料庫資料並將資料庫資料顯示在TableView上
                DispatchQueue.main.async {
                    self.toDoList = IDUS.shared.selectObject(isToDo: true)
                    self.toDoTable.reloadData()
                }
            // 3.順便清除textField
            self.textField.text = ""
        }
         
        
        
         
        
        
        
    }
    
    
    
    
    
}
