//
//  TableViewController.swift
//  DatabaseCRUD
//
//  Created by 이민우 on 2021/02/16.
//

import UIKit

class TableViewController: UITableViewController, JsonModelProtocol {

    @IBOutlet var listTableView: UITableView!
    
    var feedItem : NSArray = NSArray()
    var studentsList : [Students] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let queryModel = JsonModel()
        queryModel.delegate = self
        queryModel.downloadItems()
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.listTableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItem.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        let item : Students = feedItem[indexPath.row] as! Students
        cell.textLabel?.text = "성명 : \(item.sName!)"
        cell.detailTextLabel?.text = "전화 : \(item.sPhone!)"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView"{
            let cell = sender as! UITableViewCell
            let indexPath = self.listTableView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            
            // let item : Students = studentsList[(indexPath! as NSIndexPath).row]
            let item : Students = studentsList[indexPath!.row] // 이렇게 써도 된다.
            
            let sId = item.sId
            let sName = item.sName
            let sDept = item.sDept
            let sPhone = item.sPhone
            
            detailView.receiveItems(sId!, sName!, sDept!, sPhone!)
        }
        
        
    }

}
