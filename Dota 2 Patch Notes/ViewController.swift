//
//  ViewController.swift
//  Dota 2 Patch Notes
//
//  Created by Tony Alhwayek on 8/20/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!

    var patches = [NewsItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Loading..." // Set a placeholder title while loading
        navigationController?.navigationBar.prefersLargeTitles = true

        fetchData()
    }

    func fetchData() {
        guard let url = URL(string: "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=570&count=1&maxlength=10000&format=json") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let appNewsResponse = try decoder.decode(AppNewsResponse.self, from: data)
                    let appNews = appNewsResponse.appnews

                    // Access news items
                    for newsItem in appNews.newsitems {
                        print("Title: \(newsItem.title)")
                        print("Contents: \(newsItem.contents)")

                        self.patches.append(newsItem)

                        DispatchQueue.main.async { // Update UI on the main thread
                            self.title = newsItem.title
                            self.bodyLabel.text = newsItem.contents
                            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.bodyLabel.frame.height)
                        }
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
}


