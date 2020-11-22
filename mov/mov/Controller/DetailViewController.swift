//
//  DetailViewController.swift
//  mov
//
//  Created by Eduarda Pinheiro on 21/11/20.
//

import UIKit

class DetailViewController: UIViewController {
    

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        guard let title = movie["title"] as? String,
              let overview = movie["overview"] as? String,
              let date =  movie["release_date"] as? String

              else { return
            
        }
        
        titleLabel.text = title
        overviewLabel.text = overview
        dateLabel.text = date
       
         let baseUrl = "http://image.tmdb.org/t/p/w500/"
         if let posterPath = movie["poster_path"] as? String {
         let posterUrl = NSURL(string: baseUrl + posterPath)
          self.posterImageView.setImageWith(posterUrl! as URL)
         }

        // Do any additional setup after loading the view.
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
