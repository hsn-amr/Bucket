//
//  ViewController.swift
//  Bucket
//
//  Created by administrator on 12/12/2021.
//

import UIKit

class ViewController: UITableViewController {

    var tasks = ["Go To GYM", "Read a Book", "Clear Your Car"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // this way to access buttons on nav bar
       // navigationItem.rightBarButtonItem = UIBarButtonItem(title: <#T##String?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Saving", sender: nil)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "Saving", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let addViewController = segue.destination as! AddTableViewController
        addViewController.saveItemDeleagte = self
        if sender != nil {
            let index = sender as! Int
            let item = tasks[index]
            addViewController.index = index
            addViewController.item = item
        }
    }
   
}


extension ViewController: SaveItemDelegate {
    func saveItem(item: String, at index: Int?) {
        if let at = index {
            tasks[at] = item
        }else{
            tasks.append(item)
        }
        tableView.reloadData()
    }
    
    
}
