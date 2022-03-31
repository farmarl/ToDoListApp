 

import UIKit
import CoreData

@objc(ToDoItem)
public class ToDoItem: NSManagedObject {

}


typealias DoneHandler = (_ error: Error? ) -> Void

//core data 新刪改查元件
public class IDUS {

    static let shared = IDUS()
    private init(){  }
    
    //宣告Core Data 常數
        let coreContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    //更新資料
    func updateObject(  toDoId : String ) {
         
            //更新:將查詢到的結果更新後，再呼叫context.save()儲存
        let request = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
        request.predicate = NSPredicate(format: "%K == %@", "id", toDoId )
            do {
                let results = try self.coreContext.fetch(request)
                for item in results {
                    if item.id ==  toDoId  {
                        
                        item.date = Date()
                    }
                }
                try self.coreContext.save()
            }catch{
                fatalError("Failed to fetch data: \(error)")
            }
            //新增完畢後查詢資料庫資料並將資料庫資料顯示在TableView上
//            self.memberList = self.selectObject()
//            DispatchQueue.main.async {
//                self.memberTableView.reloadData()
//            }
        
    }
    
    
    //查詢資料  isToDo ->
    func selectObject( isToDo : Bool) -> Array<ToDoItem> {
          var array:[ToDoItem] = []
          let request = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
        if isToDo {
            request.predicate = NSPredicate(format: "%K == nil ", "date" )
        }else{
            request.predicate = NSPredicate(format: "%K != nil ", "date" )
        }
          do {
              let results = try self.coreContext.fetch(request)
              for result in results {
                  array.append(result)
              }
              
          }catch{
              fatalError("Failed to fetch data: \(error)")
          }
          return array
          
      }
    
    
    func addOne( textString : String , complite : DoneHandler ){
        // 1.寫入到coredata
        let toDoItem = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: self.coreContext) as! ToDoItem
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd-HH:mm:ss"
      //  id 由當下時間加亂數決定
        let toDoId = df.string(from: Date()) + "-" + String( Int.random(in: 1..<10000) )
        
        toDoItem.id = toDoId
        toDoItem.text = textString
        
        
        
            do {
                try self.coreContext.save()
                complite(nil) //成功不給error
            } catch {
                complite(error) //給error
                fatalError("\(error)")
            }
        
        
         
        
    }
}
