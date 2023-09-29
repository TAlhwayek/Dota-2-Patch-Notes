//
//  UpdatesTableViewController.swift
//  Dota 2 Patch Notes
//
//  Created by Tony Alhwayek on 8/23/23.
//

import UIKit

class UpdatesTableViewController: UITableViewController {
    
    var filteredNewsItems: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Previous Updates"
        applyCustomizations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update filteredNewsItems with the latest data from SharedDataModel
        filteredNewsItems = SharedDataModel.shared.filteredNewsItems
        // Remove latest update from array to not show up in previous updates
        filteredNewsItems.removeFirst()
        tableView.separatorColor = .lightGray
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNewsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredNewsItems[indexPath.row].title
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .red
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? PatchDetailViewController {
            detailVC.patchTitle = filteredNewsItems[indexPath.row].title
            detailVC.body = filteredNewsItems[indexPath.row].contents
            navigationController?.pushViewController(detailVC, animated: true)
        }
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
