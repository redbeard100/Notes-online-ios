//
//  ViewController.swift
//  Notes
//
//  Created by Soumil on 24/04/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var AddNewButton: UIButton!
    let addNewFileViewController = AddNewFileViewController()
    @IBOutlet weak var filesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataOperations.shared.fetchData()
        AddNewButton.layer.masksToBounds = true
        AddNewButton.layer.cornerRadius = AddNewButton.frame.width/2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DataOperations.shared.fetchData()
        filesTable.reloadData()
    }
    
    //    MARK:- Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = DataModel.shared.name[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let AddFileVC : AddNewFileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFileVC") as! AddNewFileViewController
        AddFileVC.indexNo = indexPath.row
        AddFileVC.flagUpdate = 1
        navigationController?.pushViewController(AddFileVC, animated: true)
    }
    
    //    MARK:- Delete Table rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            DataOperations.shared.deleteData(index: indexPath.row)
            tableView.reloadData()
        }
    }
}

