//
//  DetailArticleViewController.swift
//  Codepath_IOS101_Capstone
//
//  Created by mary ramirez on 11/16/25.
//

import UIKit
import NukeExtensions

class DetailArticleViewController: UIViewController {
    
    @IBOutlet weak var articleTitlelLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var linkArticleButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            // 1.
            article.addToFavorites()
        } else {
            // 2.
            article.removeFromFavorites()
        }
        
    }
    
    
    @IBAction func didTapWatchlistButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            article.addToWatchlist()
        } else {
            article.removeFromWatchlist()
        }
    }
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        watchListButton.layer.cornerRadius = watchListButton.frame.width / 2
       shareButton.layer.cornerRadius = shareButton.frame.width / 2
        
        let read = Article.getArticles(forKey: Article.readKey)
        if read.contains(article) {
            favoriteButton.isSelected = true
        } else {
            favoriteButton.isSelected = false
        }
        
        let watchlist = Article.getArticles(forKey: Article.watchlistKey)
               if watchlist.contains(article) {
                   watchListButton.isSelected = true
               } else {
                   watchListButton.isSelected = false
               }
        
        
        articleImageView.clipsToBounds = true
        articleImageView.contentMode = .scaleAspectFill
        
        // Do any additional setup after loading the view.
        articleTitlelLabel.text = article.title
        
        if let imagePath = article.urlToImage, let imageUrl = URL(string: imagePath) {
            NukeExtensions.loadImage(
                with: imageUrl,
                options: .init(placeholder: UIImage(named: "placeholder")),
                into: articleImageView
            )
        } else {
            
            articleImageView.image = UIImage(named: "placeholder")
        }
        
        sourceLabel.text=article.source.name
        
        if let publishedAtString = formatToHumanReadable(article.publishedAt) {
            publishedDateLabel.text = "Published: \(publishedAtString)"
        } else {
            publishedDateLabel.text = "Published:: Unknown"
        }
        
        if let articleAuthor = article.author {
            authorLabel.text = "Author: \(articleAuthor)"
        } else {
            authorLabel.text = "Author: Unknown"
        }
        
        descriptionLabel.text = article.description
        
        if let url = URL(string: article.url), UIApplication.shared.canOpenURL(url) {
            linkArticleButton.isEnabled = true
        } else {
            linkArticleButton.isEnabled = false
        }
        
    }
    
    @IBAction func linkArticleButtonTapped(_ sender: Any) {
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: article.url) else { return }

            // Si la imagen existe, también la compartimos
            if let image = articleImageView.image {
                let items: [Any] = [article.title, url, image]
                let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = sender // evitar crash en iPad
                present(activityVC, animated: true)
            } else {
                // Si no hay imagen, compartimos solo título y link
                let items: [Any] = [article.title, url]
                let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = sender
                present(activityVC, animated: true)
            }
    }
    
    func formatToHumanReadable(_ isoString: String) -> String? {
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            let fallbackFormatter = ISO8601DateFormatter()

            var date: Date?
            if let parsedDate = isoFormatter.date(from: isoString) {
                date = parsedDate
            } else {
                date = fallbackFormatter.date(from: isoString)
            }

            guard let finalDate = date else { return nil }

            let readableFormatter = DateFormatter()
            readableFormatter.locale = Locale.current
            readableFormatter.dateStyle = .medium
            readableFormatter.timeStyle = .short

            return readableFormatter.string(from: finalDate)
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
