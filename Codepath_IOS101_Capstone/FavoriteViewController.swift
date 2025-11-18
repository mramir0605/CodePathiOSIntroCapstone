//
//  FavoriteViewController.swift
//  Codepath_IOS101_Capstone
//
//  Created by mary ramirez on 11/16/25.
//

import UIKit
import NukeExtensions

class FavoriteViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var emptyFavoritesLabel: UILabel!
    
    var favoriteArticles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        defer {
            //emptyFavoritesLabel.isHidden = !favoriteArticles.isEmpty
        }
        
        let articles = Article.getArticles(forKey: Article.readKey)
        self.favoriteArticles = articles
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        let article = favoriteArticles[indexPath.row]
        if let imagePath = article.urlToImage {
            let imageUrl = URL(string: imagePath)
            NukeExtensions.loadImage(with: imageUrl, into: cell.ArticleImageView)
        }
        cell.titleLabel.text = article.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        let selectedArticle = favoriteArticles[selectedIndexPath.row]
        guard let detailViewController = segue.destination as? DetailArticleViewController else { return }
        detailViewController.article = selectedArticle
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
