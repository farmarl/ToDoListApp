 
import UIKit

class ToDoTableViewCell: UITableViewCell {

    var toDoId : String = ""
    var cellIndex : Int = -1
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func complite(_ sender: Any) {
        
        print("--cell complite:\(self.toDoId)")
         
        // 1. 把該筆資料寫入Date
        IDUS.shared.updateObject(toDoId: self.toDoId)
        
        
        // 2.把該筆資料從toDoList移除
        // 2 方案1 只remove cell 然後讓todotable自己reload 缺點: 運算量較大 空格殘留
       // self.removeFromSuperview()
        
        // 2 方案2 用通知中心分別通知資料變動  缺點:code跟邏輯都會變複雜難以維護
        NotificationCenter.default.post(name: .cellUpdated, object: nil, userInfo: ["cellIndex":cellIndex])
        
        
        
        
    }
}
