//
//  TaskTableViewController.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 07/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    var task = Task()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllTaks()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        let custom = cell as! TaskTableViewCell
        let content = task.results![indexPath.row]
        custom.title.text = content.title
        custom.descriptionn.text = content.descriptionn
        custom.expirationDate.text = content.expiration_date
        custom.imgComplete.isHidden = !content.is_complete!
        
        return custom
    }
    
    func getAllTaks()  {
        self.showLoanding()
        AppService().getAllTasks(Success: { response in
            if response?.httpStatusCode == 200{
                self.task = (response?.body)!
                self.tableView.reloadData()
            }
        }, onError: { error in
            print(error?.cause)
        }, always: {
            self.hideLoading()
        })
    }
    
}
