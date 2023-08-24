//
//  UpdatesTableViewController.swift
//  Dota 2 Patch Notes
//
//  Created by Tony Alhwayek on 8/23/23.
//

import UIKit

class UpdatesTableViewController: UITableViewController {
    
    var filteredNewsItems = SharedDataModel.shared.filteredNewsItems
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Previous Updates"
        view.backgroundColor = .white
        print(filteredNewsItems.count)
        
        applyCustomizations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update filteredNewsItems with the latest data from SharedDataModel
        filteredNewsItems = SharedDataModel.shared.filteredNewsItems
        tableView.separatorColor = .lightGray
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNewsItems.count - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredNewsItems[indexPath.row].title
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .red
        print(filteredNewsItems[indexPath.row].title)
        return cell
    }
    
    func applyCustomizations() {
        // Customizing large title
        if let titleFont = UIFont(name: "Helvetica-Bold", size: 22) {
            navigationController?.navigationBar.largeTitleTextAttributes = [
                .font: titleFont,
                .foregroundColor: UIColor.red
            ]
        }
        
        // Customizing regular nav bar title
        navigationController?.navigationBar.titleTextAttributes  = [
            .foregroundColor: UIColor.red
        ]
    
        navigationController?.navigationBar.barTintColor = .black
        
        // Make all backgrounds black
        view.backgroundColor = .black
    }
    
}
