//
//  TabBarFirstController.swift
//  trabalhoFinal
//
//  Created by Daniel Garcia on 01/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func downloadImageAsync(url: URL) {
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self]
            (data, response, error) in
            guard error == nil else {
                print(error ?? "Erro ao realizar o download da imagem.")
                return
            }
            DispatchQueue.main.async { [weak self] in
                let image = UIImage(data: data!)
                self?.image = image
            }
        }).resume()
    }
}


class TabBarFirstController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    lazy var repos = [Repos]()
    lazy var originalRepos = [Repos]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        if users.count > lastIndex {
            for i in lastIndex..<users.count {
                let urlString = "https://api.github.com/users/\(users[i].login)/repos"
                guard let url = URL(string: urlString) else { return }
                
                URLSession.shared.dataTask(with: url) {
                    [weak self]  (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    guard let data = data else { return }
                    do {
                        let repositorios = try JSONDecoder().decode([Repos].self, from: data)
                        DispatchQueue.main.async { [weak self]  in
                            self?.repos.append(contentsOf: repositorios)
                            self?.originalRepos.append(contentsOf: repositorios)
                            self?.tableView.reloadData()
                        }
                    } catch let jsonError {
                        print(jsonError)
                    }
                    }.resume()
            }
            lastIndex = users.count
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellArtistas", for: indexPath)
        let custom = cell as! TableViewCellArtista
        
        let content = repos[indexPath.row]
    
        custom.title.text = content.name
        custom.subscription.text = content.html_url
        custom.img.downloadImageAsync(url: URL(string: content.owner.avatar_url)!)
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            repos = originalRepos
            tableView.reloadData()
            return
        }
        let filtered = originalRepos.filter {
            let textToSearch = "\($0.name) \($0.html_url)"
            return textToSearch.range(of: searchText) != nil
        }
        repos = filtered
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    

}
