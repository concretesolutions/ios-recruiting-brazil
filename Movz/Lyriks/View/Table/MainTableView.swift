//
//  MainTableView.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 03/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class MainTableView: UITableView {

    var data:[TableCellViewModel] = []{
            didSet{
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    var paging:Bool = false
    var didSelect:((TableCellViewModel)->Void)?
    var pageCount = 1
    var canRefresh = true
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    convenience init(data:[TableCellViewModel]) {
        self.init(frame: CGRect.zero, style: UITableView.Style.plain)
        self.data = data
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
        Convert data to table model
    */
    func convertToModel(movie:[Movie]) -> [TableCellViewModel]{
        var modelArray:[TableCellViewModel] = []
        movie.forEach { (movie) in
            modelArray.append(TableCellViewModel(movie: movie))
        }
        return modelArray
    }
    /**
        Get new page for table
    */
    func newPage(){
        self.pageCount+=1
        MovieAPI.movieRequest(mode:Request.popular(self.pageCount),sort:Sort.desc(.voteAverage)){
            [weak self]request,err  in
            if err != nil{
                return
            }
            guard let self = self else{
                return
            }
            for movie in request{
                self.data.append(TableCellViewModel(movie: movie))
            }
            DispatchQueue.main.async {
                self.reloadData()
                
            }
            self.canRefresh = true
            
        }
        
    }
}
extension MainTableView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(data[indexPath.item])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableViewCell.cellHeigth
    }
    /**
        identify when to add page
    */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - MainTableViewCell.cellHeigth*self.bounds.height/MainTableViewCell.cellHeigth) && self.canRefresh){
            if paging {
                newPage()
            }
            canRefresh = false
        }
    }
}
extension MainTableView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else{
            return MainTableViewCell(style: .default, reuseIdentifier: MainTableViewCell.identifier)
        }
        cell.setUp(model: data[indexPath.item])
        return cell
        
    }
    
    
}
