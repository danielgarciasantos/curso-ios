//
//  TabBarUserController.swift
//  trabalhoFinal
//
//  Created by Daniel Garcia on 01/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit

class TabBarUserController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUser", for: indexPath)
        let custom = cell as! TableViewCellUser
        
        let content = users[indexPath.row]
        
        custom.title.text = content.name ?? content.login
        custom.detail.text = content.company
        custom.img?.downloadImageAsync(url: URL(string: content.avatar_url!)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    @IBAction func adduser(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add New user GitHub!", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            let text = alertController.textFields?[0].text
            if (text?.isEmpty)! {
                return
            }
            self.adicionarUser(nameUser: text!)
           
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter user gitHub"
        }
        saveAction.setValue(#imageLiteral(resourceName: "Rectangle 1306"), forKey: "image")
        alertController.addAction(saveAction)
        cancelAction.setValue(#imageLiteral(resourceName: "Cancel"), forKey: "image")
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        let userRafagan = User(avatar_url: "https://avatars2.githubusercontent.com/u/2295481?v=4", login: "rafagan", company: "Guizion Labs, PUCPR", name: "Ráfagan Abreu")
        users.append(userRafagan)
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func adicionarUser(nameUser name: String) {
        
        
        let urlString = "https://api.github.com/users/\(name)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {
            [weak self]  (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            if (response as?  HTTPURLResponse)?.statusCode ==  404 {
                let alert = UIAlertController(title: "Antençao!", message: "Usuario não existe no gitHub.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                }))
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let data = data else { return }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async { [weak self]  in
                    users.append(user)
                    self?.tableView.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
        
    }


}
