

import UIKit

import CoreData



class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    var  keyboardHeight : CGFloat = 0.0
    var  keyboardIsUp : Bool = false
    
    var  toDoList : [ToDoItem] = []
    @IBOutlet weak var toDoTable: UITableView!
    
    
   var spinner = UIActivityIndicatorView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //讓tableView不要擋住textfield
        self.view.sendSubviewToBack(self.toDoTable)
        
        spinner.style = .large
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 150.0),
                                      spinner.centerXAnchor.constraint(equalTo:  view.centerXAnchor)])
       // spinner.startAnimating()
        
        //註冊 鍵盤通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        //註冊 cell通知
        NotificationCenter.default.addObserver( self , selector: #selector(finishCellUpdate) , name: .cellUpdated , object: nil)
        
        
        
        //設定點旁邊關閉鍵盤
        let tap = UITapGestureRecognizer(target: view , action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        toDoTable.delegate = self
        toDoTable.dataSource = self

        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //從coredata撈資料
        self.toDoList = IDUS.shared.selectObject(isToDo: true)
        self.toDoTable.reloadData()
    }
    
    
    @IBAction func sendToDo(_ sender: UIButton) {
        
        
        
        if (  ( textField.text != nil ) && !textField.text!.isEmpty ) {
            self.textField.tintColor = .black
            self.textField.textColor = .black
            self.textField.backgroundColor =  .white
            
            
            //進階 呼叫個func delay 1300ms 並使user不能使用
            fakeDelay { error in
                print("完成")
                
                
                self.newOne()
                
            }
            
            
            
            
        }else{
            //無值  跳alert
            
            self.textField.tintColor = .red
            self.textField.textColor = .white
            self.textField.backgroundColor = .darkGray
            
            
            let controller = UIAlertController(title: "待辦事項未填寫" , message: "請輸入待辦事項", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
            
        }
        
        
    }
    
    

    @objc func finishCellUpdate(notification : Notification){
        
        if let cellIndex = notification.userInfo?["cellIndex"]{
          
             print("--被通知--cellIndex:\(cellIndex)")
            self.toDoList.remove(at: cellIndex as! Int)
           
            self.toDoTable.reloadData()
            
        }
        
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



//通知
extension Notification.Name{
    
    static let cellUpdated = Notification.Name("cellUpdated")
}
