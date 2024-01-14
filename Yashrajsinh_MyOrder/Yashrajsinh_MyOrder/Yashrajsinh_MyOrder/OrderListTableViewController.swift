//
//  OrderListTableViewController.swift
//  Yashrajsinh_MyOrder
//
//  Created by user217595 on 5/16/22.
//

import UIKit

class OrderListTableViewController: UITableViewController {
    
    private var orderlist : [OrderList] = [OrderList]()
    private let dbHelper = CoreDBHelper.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchAllTasks()
        
        self.tableView.rowHeight = 90
        
    }

    private func fetchAllTasks(){
        let data = self.dbHelper.getAllTasks()
        
        if ( data != nil){
            self.orderlist = data!
            self.tableView.reloadData()
        }else{
            print(#function, "No data received from DB")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  self.orderlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_orderList", for: indexPath) as! OrderListTableViewCell
        
        if indexPath.row < orderlist.count{
            
            let currentOrder = self.orderlist[indexPath.row]
            
            cell.coffeeType.text = currentOrder.coffeeType
            cell.coffeSize.text = currentOrder.coffeeSize
            cell.quantity.text = currentOrder.quantity
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete"){
            
            (action, view, completionHandler) in
            
            let orderToDelete = self.orderlist[indexPath.row]
            
            self.dbHelper.deleteOrder(order: orderToDelete)
            
            self.fetchAllTasks()
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let orderQuantity = orderlist[indexPath.row]
        
        let alert = UIAlertController(title: "Edit Order Quantity", message: "Enter Quantity", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.text = orderQuantity.quantity
        alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {[weak self] _ in
            
            guard let field = alert.textFields?.first, let newOrderQuantity = field.text, !newOrderQuantity.isEmpty else{
                return
            }
            self?.fetchAllTasks()
            self?.dbHelper.updateTask(updatedOrderQuantity: orderQuantity, newQuantity: newOrderQuantity)
        }))
        self.present(alert, animated: true)
       
    }
        
}
