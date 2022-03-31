

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}

extension ToDoItem : Identifiable {

}
