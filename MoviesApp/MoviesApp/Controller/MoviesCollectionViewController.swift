//
//  MoviesCollectionViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 11/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //API Consuming code begins here
        if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=bd67e085700f352302ea910f619fe7ec&language=en-US&page=1"){
            let task = URLSession.shared.dataTask(with: url) { (data, request, error) in
                
                if error == nil {
                    print("Sucessfully retrieved data")
                    
                    if let retrievedData = data {
                        do{
                            if let jsonObject = try JSONSerialization.jsonObject(with: retrievedData, options: []) as? [String:Any] {
                                
                                if let resultsArray = jsonObject["results"] as? [[String: Any]]{
                                    
                                    for result in resultsArray{
                                        if let title = result["title"]{
                                            print(title)
                                        }
                                        if let releaseDate = result["release_date"]{
                                            print(releaseDate)
                                        }
                                        if let overview = result["overview"]{
                                            print(overview)
                                        }
                                        print("########################")
                                    }
                                    
                                }
                                
//                                for jsonObject in jsonObjects {
//                                    //print(jsonObject["title"])
//                                    print(jsonObject["results"])
//                                }
                                
                            //print(jsonObjects)
                                
                            }
                        }catch{
                            print("Error serializing retrieved JSON")
                        }
                    }
                    
                }else{
                    print("Failed to retrieve data")
                }
                
            }
            task.resume()
        }
        //API Consuming code ends here

        
     
    
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }


}
