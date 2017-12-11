//
//  TaskTableViewController.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 07/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController , UISearchBarDelegate{
    
    lazy var task = Task()
    lazy var taskOriginal = [Result]()
    var searchBar : UISearchBar!
    var taskSelected = Result()
    
    @IBOutlet weak var btnAddTask: UIBarButtonItem!
    @IBOutlet weak var botaoSearch: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.searchBar != nil {
            self.searchBar(self.searchBar, textDidChange: self.searchBar.text!)
            searchBar.becomeFirstResponder()
        }else {
            getAllTaks()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SalvarViewController {
            if segue.identifier == "editTask" {
                dest.editTaks = true
            }
            dest.taskSelected = self.taskSelected
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.taskSelected  = task.results![indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "editTask", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.results?.count ?? 0
    }
    
    @IBAction func btnSearch(_ sender: UIBarButtonItem) {
        searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Pesquisar"
        searchBar.delegate = self
        searchBar.tintColor = UIColor.white
        searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchBar
        self.botaoSearch.isEnabled = false
        self.botaoSearch.tintColor = UIColor.clear
        self.btnAddTask.isEnabled = false
        self.btnAddTask.tintColor = UIColor.clear
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearch()
    }
    func cancelSearch() {
        self.navigationItem.titleView = nil
        self.btnAddTask.isEnabled = true
        self.btnAddTask.tintColor = UIColor.white
        self.botaoSearch.isEnabled = true
        self.botaoSearch.tintColor = UIColor.white
        task.results = taskOriginal
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            deleteTask(indexPath: indexPath)
        }
    }
    
    func deleteTask(indexPath: IndexPath) {
        let result = task.results![indexPath.row]
        self.showLoanding()
        AppService().deleteTask(task: result, Success: { reponse in
            self.task.results?.remove(at: indexPath.row)
            self.taskOriginal.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }, onError: { error in
            
        }, always: {
            self.hideLoading()
        })
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        let custom = cell as! TaskTableViewCell
        let content = task.results![indexPath.row]
        custom.title.text = content.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: content.expiration_date!)
        
        let dateFormatterBR = DateFormatter()
        dateFormatterBR.dateFormat = "dd-MM"
        
        custom.expirationDate.text = dateFormatterBR.string(from: date!)
        custom.descriptionn.text = content.descriptionn
        custom.imgComplete.isHidden = !content.is_complete!
        
        return custom
    }
    
    func getAllTaks()  {
        self.showLoanding()
        AppService().getAllTasks(Success: { response in
            if response?.httpStatusCode == 200{
                self.task = (response?.body)!
                self.taskOriginal = self.task.results!
                self.tableView.reloadData()
            }
        }, onError: { error in
        }, always: {
            self.hideLoading()
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            task.results = taskOriginal
            tableView.reloadData()
            return
        }
        let filtered = taskOriginal.filter {
            let textToSearch = "\($0.descriptionn!) \($0.title!)"
            return textToSearch.range(of: searchText) != nil
        }
        task.results = filtered
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
