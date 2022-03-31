
import UIKit

extension ToDoListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        let cell : ToDoTableViewCell
        
        cell = toDoTable.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        
        cell.textLabel?.text = self.toDoList[indexPath.row].text
        cell.toDoId  = self.toDoList[indexPath.row].id ?? "n/a" //理論上不該發生
        cell.cellIndex = indexPath.row
 
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--Ya~~~\(indexPath.row)")
    }
    
    
    
}
