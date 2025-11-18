//
//  ViewController.swift
//  Codepath_IOS101_Capstone
//
//  Created by mary ramirez on 11/15/25.
//
import UIKit
import NukeExtensions

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    
    
    //TODO: Add table view outlet
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    //TODO: Add property to store fetched articles array
    private var articles: [Article] = []
    
    private var filteredArticles: [Article] = []
    
    private var searchTimer: Timer?
  
    
       override func viewDidLoad() {
           super.viewDidLoad()
           
           tableView.dataSource = self
           searchBar.delegate = self
           
           fetchNews()
       }
       
       // MARK: - TableView DataSource
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return filteredArticles.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
           let article = filteredArticles[indexPath.row]
           
           if let imagePath = article.urlToImage,
              let imageUrl = URL(string: imagePath) {
               NukeExtensions.loadImage(
                   with: imageUrl,
                   options: .init(placeholder: UIImage(named: "placeholder")),
                   into: cell.ArticleImageView
               )
           } else {
               cell.ArticleImageView.image = UIImage(named: "placeholder")
           }
           
           cell.titleLabel.text = article.title
           return cell
       }
       
       // MARK: - Prepare for Segue
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
           let selectedArticle = filteredArticles[selectedIndexPath.row]
           guard let detailArticleVC = segue.destination as? DetailArticleViewController else { return }
           detailArticleVC.article = selectedArticle
       }
       
       // MARK: - Search Bar Delegate
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           // Cancel any pending timer
           searchTimer?.invalidate()
           
           searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
               if searchText.isEmpty {
                   self.filteredArticles = self.articles
               } else {
                   self.filteredArticles = self.articles.filter { article in
                       let titleMatches = article.title.lowercased().contains(searchText.lowercased())
                       let descriptionMatches = article.description?.lowercased().contains(searchText.lowercased()) ?? false
                       return titleMatches || descriptionMatches
                   }
               }
               self.updateTableBackground()
               self.tableView.reloadData()
           })
       }
    
    private func updateTableBackground() {
        if filteredArticles.isEmpty {
            let messageLabel = UILabel()
            messageLabel.text = "No news found for your search."
            messageLabel.textColor = .gray
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            messageLabel.numberOfLines = 0
            tableView.backgroundView = messageLabel
        } else {
            tableView.backgroundView = nil
        }
    }
       
       // MARK: - Fetch News
       
       private func fetchNews() {
           let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=c56d1ad0add340b8bf526284b3ac79c9"
           let url = URL(string: urlString)!
           let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
           
           let session = URLSession.shared.dataTask(with: request) { data, response, error in
               
               if let error = error {
                   print("🚨 Request failed: \(error.localizedDescription)")
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                   print("🚨 Server error")
                   return
               }
               
               guard let data = data else {
                   print("🚨 No data")
                   return
               }
               
               do {
                   let decoder = JSONDecoder()
                   let newsFeedResponse = try decoder.decode(NewsFeed.self, from: data)
                   let articles = newsFeedResponse.articles
                   
                   DispatchQueue.main.async { [weak self] in
                       self?.articles = articles
                       self?.filteredArticles = articles
                       self?.updateTableBackground()
                       self?.tableView.reloadData()
                   }
               } catch {
                   print("🚨 Error decoding JSON data: \(error.localizedDescription)")
               }
           }
           
           session.resume()
       }
   }
