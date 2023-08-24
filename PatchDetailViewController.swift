//
//  PatchDetailViewController.swift
//  Dota 2 Patch Notes
//
//  Created by Tony Alhwayek on 8/23/23.
//

import UIKit

class PatchDetailViewController: UIViewController {

    var patchTitle: String!
    var body: String!
    
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        title = patchTitle
        bodyLabel.text = body
        view.backgroundColor = .black
        applyCustomizations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black
        
        // Make all backgrounds black
        backgroundView.backgroundColor = .black
        scrollView.backgroundColor = .black
        bodyLabel.backgroundColor = .black
        bodyLabel.textColor = .lightGray
        
        bodyLabel.isUserInteractionEnabled = true
    }
}
