//
//  ViewController.swift
//  Dota 2 Patch Notes
//
//  Created by Tony Alhwayek on 8/20/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        // Place holder in case API takes longer than expected
        title = "Loading API..."
        bodyLabel.text = "Also loading..."
        
        // Customizing the UI
        applyCustomizations()
        
        // Get data from API and update app
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=570&count=200&maxlength=10000&format=json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let appNewsResponse = try decoder.decode(AppNewsResponse.self, from: data)
                    let appNews = appNewsResponse.appnews
                    
                    // Filter news items with titles starting with "Dota 2 Update"
                    let filteredNewsItems = appNews.newsitems.filter { $0.title.hasPrefix("Dota 2 Update") }
                    SharedDataModel.shared.filteredNewsItems = filteredNewsItems
                    
                    //MARK: - This is where I change which update is displayed
                    // This note is so that I can easily find it
                    let newsItem = filteredNewsItems[0]
                    // Remove the unnecessary image text at the beginning of each body
                    let pattern = "\\{STEAM_CLAN_IMAGE\\}/[a-zA-Z0-9]+/[a-zA-Z0-9]+\\.png "
                    let regex = try! NSRegularExpression(pattern: pattern, options: [])
                    let modifiedContents = regex.stringByReplacingMatches(
                        in: newsItem.contents,
                        options: [],
                        range: NSRange(location: 0, length: newsItem.contents.utf16.count),
                        withTemplate: ""
                    )
                    // Add a bullet point before each "Fixed"
                    let modifiedContentsWithNewlines = modifiedContents
                        .replacingOccurrences(of: "Fixed", with: "\n\n • Fixed")
                      //  .replacingOccurrences(of: "\r\n", with: "\n\n\n\n\n\n", options: .regularExpression)
                    

                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        self.bodyLabel.text = modifiedContentsWithNewlines
                        self.title = newsItem.title
                        self.navigationController?.navigationBar.prefersLargeTitles = true
                    }
                } catch {
                    print("JSON decoding error: \(error.localizedDescription)")
                }
            }
        }.resume()
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


