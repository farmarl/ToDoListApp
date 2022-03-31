 

import UIKit

class DidListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell
        
        cell = didTable.dequeueReusableCell(withIdentifier: "DidCell", for: indexPath)
        
        cell.textLabel?.text = self.didList[indexPath.row].text
        //在did一定有date
        guard let celldate = self.didList[indexPath.row].date else{return cell}
        print("\(self.didList[indexPath.row].text):\(celldate)")
        let timeDistance = Date().timeIntervalSinceReferenceDate - celldate.timeIntervalSinceReferenceDate
        if timeDistance > 86400 {//超過一天
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
           
            let time = formatter.string(from: celldate)
            cell.detailTextLabel?.text = "\(time)"
            
        }else{
            print("timeDistance:\(timeDistance)")

            let secInt = Int(timeDistance)%60
            let minsInt = Int(timeDistance/60)%60
            let hourInt = Int(timeDistance/3600)%24
            
            print("\(hourInt):\(minsInt):\(secInt)")
            var distanceString = ""
            if hourInt > 0 {
                distanceString = "\(hourInt)小時"
            }
            if minsInt > 0 {
                distanceString = distanceString + "\(minsInt)分"
            }
            if secInt > 0 {
                distanceString = distanceString + "\(hourInt)秒"
            }
            
            
            cell.detailTextLabel?.text = distanceString + "前"
        }
         
 
 
        return cell
    }
    

    @IBOutlet weak var didTable: UITableView!
    
    var  didList : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.didTable.delegate = self
        self.didTable.dataSource = self
        print("--didVC")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //從coredata撈資料
        self.didList = IDUS.shared.selectObject(isToDo: false)
        self.didTable.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
