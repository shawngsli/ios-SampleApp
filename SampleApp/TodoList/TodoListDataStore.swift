//
//  TodoItemDataStore.swift
//  SampleApp
//
//  Created by  dlc-it on 2019/3/30.
//  Copyright © 2019 shawnli. All rights reserved.
//

import UIKit

class TodoListDataStore {    
    subscript(index: Int) -> TodoItem? {
        return self.getTodoItems()?[index]
    }
    
    func count() -> Int {
        return self.getTodoItems()?.count ?? 0
    }
    
    func addItem(content: String) {
        let todoItem = TodoItem(context: self.managedObjectContext)
        todoItem.content = content
        self.saveContext()
    }
    
    func deleteItem(at index: Int) {
        if let todoItem = self.getTodoItems()?[index] {
            self.managedObjectContext.delete(todoItem)
            self.saveContext()
        }
    }
    
    private let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func getTodoItems() -> [TodoItem]? {
        return try? self.managedObjectContext.fetch(TodoItem.fetchRequest())
    }
    
    private func saveContext() {
        do {
            try self.managedObjectContext.save()
        } catch {
            return
        }
    }
}
