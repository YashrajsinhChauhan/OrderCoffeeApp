//
//  CoreDBHelper.swift
//  Yashrajsinh_MyOrder
//
//  Created by user217595 on 5/16/22.
//

import Foundation
import CoreData
import UIKit

class CoreDBHelper {
    
    private static var shared : CoreDBHelper?
    private let moc : NSManagedObjectContext
    private let ORDERLIST = "OrderList"
    
    static func getInstance() -> CoreDBHelper{
        
        if shared == nil{
          
            shared = CoreDBHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
        
        return shared!
    }
    
    private init(context : NSManagedObjectContext){
        self.moc = context
    }
    
    func insertTask(coffeeType: String, coffeeSize: String, quantity: String){
        do{
            
            let orderToBeInserted = NSEntityDescription.insertNewObject(forEntityName: ORDERLIST, into: self.moc) as! OrderList
            
            orderToBeInserted.coffeeType = coffeeType
            orderToBeInserted.coffeeSize = coffeeSize
            orderToBeInserted.quantity = quantity
            orderToBeInserted.orderDate = Date()
            
            if self.moc.hasChanges{
                try self.moc.save()
                
                print(#function, "Data is saved in CoreData")
            }
            
        }catch let error as NSError{
            print(#function, "Could not save the data \(error)")
        }
    }
    
    func getAllTasks() -> [OrderList]?{
        
        let fetchRequest = NSFetchRequest<OrderList>(entityName: ORDERLIST)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "orderDate", ascending: false)]
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "Fetched Data : \(result as [OrderList])")
            
            return result as [OrderList]
            
        }catch let error as NSError{
            print(#function, "Could not fetch the data \(error)")
        }
        
        return nil
    }
    
    func deleteOrder(order: OrderList) {
        
        self.moc.delete(order)
        
        do{
            try self.moc.save()
        }
        catch let error as NSError{
            print(#function, "Could not delete the data \(error)")
        }
    }
    
    func updateTask(updatedOrderQuantity: OrderList, newQuantity: String){
        
        updatedOrderQuantity.quantity = newQuantity
        
        do {
            try self.moc.save()
        }
        catch let error as NSError{
            print(#function, "Could not update the data \(error)")
        }
        
    }
}
