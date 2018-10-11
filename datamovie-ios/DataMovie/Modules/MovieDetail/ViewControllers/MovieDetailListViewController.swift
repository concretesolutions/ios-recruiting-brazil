//
//  MovieDetailListViewController.swift
//  DataMovie
//
//  Created by Andre Souza on 03/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import SafariServices

class MovieDetailListViewController: UIViewController {
    
    @IBOutlet weak var tableViewFooter: UIView!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var footerButton: UIButton!
    @IBOutlet weak var footerActivity: UIActivityIndicatorView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    
    private lazy var footerHeight: CGFloat =  60
    private lazy var rowHeight: CGFloat = {
        if detailContent == .trailer {
            return 100
        } else {
            return 115
        }
    }()
    
    var detailContent: MovieDetailContent!
    var presenter: MovieDetailPresenterInterface?
    
    class func newInstance(detailContent: MovieDetailContent) -> MovieDetailListViewController {
        let storyboard = UIStoryboard(type: .movieDetail)
        let detailListVC = storyboard.instantiateViewController(ofType: MovieDetailListViewController.self)
        detailListVC.detailContent = detailContent
        return detailListVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MovieDetailListViewController {
    
    private func initialSetup() {
        view.backgroundColor = .clear
        setupFirstHeight()
        showInformation()
    }
    
    private func setupTableView() {
        if detailContent == .trailer {
            tableView.register(TrailerTableViewCell.self)
        } else {
            tableView.register(MovieListTableViewCell.self)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupFirstHeight() {
        let viewScrollingHeight = view.frame.height - ceil(presenter?.topCardviewHeight ?? 0) - (UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0)
        tableViewHeight.constant = viewScrollingHeight
    }
    
}

extension MovieDetailListViewController: MovieDetailListViewInterface {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func reloadData(at index: IndexPath) {
        tableView.reloadRows(at: [index], with: .none)
    }
    
    func showFooterMessage(message: String, buttonText: String?, target: Any?, action: Selector?) {
        footerButton.removeTarget(nil, action: nil, for: .allEvents)
        if let target = target, let action = action {
            footerButton.isHidden = false
            footerButton.setTitle(buttonText, for: .normal)
            footerButton.addTarget(target, action: action, for: .touchUpInside)
        } else {
            footerButton.isHidden = true
        }
        
        footerLabel.text = message
        footerActivity.isHidden = true
        tableViewFooter.isHidden = false
    }
    
    func showFooterLoading(text: String) {
        footerLabel.text = text
        footerButton.isHidden = true
        footerActivity.isHidden = false
        tableViewFooter.isHidden = false
    }
    
    func updateItemStatus(with movieID: Int, isComplete: Bool) {
        presenter?.updateItemStatus(with: movieID, isComplete: isComplete)
    }
    
    var viewController: UIViewController {
        return self
    }

    func showInformation() {
        if detailContent == .trailer {
            tableViewFooter.isHidden = true
            tableView.reloadData()
            resizeTableview()
        } else {
            presenter?.loadRelatedMovies()
        }
    }
    
    func resizeTableview() {
        var allRowsHeight: CGFloat = 0
        if detailContent == .trailer {
            let videosCount = presenter?.numberOfItems(at: detailContent, in: 0) ?? 0
            allRowsHeight = CGFloat(videosCount) * rowHeight + footerHeight
            if videosCount == 0 {
                showFooterMessage(message: "No trailers found.")
            }
        } else {
            allRowsHeight = CGFloat(presenter?.numberOfItems(at: detailContent, in: 0) ?? 0) * rowHeight + footerHeight
        }
        tableViewHeight.constant = max(allRowsHeight, tableViewHeight.constant)
    }
    
}

// MARK: - UITableViewDataSource -

extension MovieDetailListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections(at: detailContent) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems(at: detailContent, in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if detailContent == .trailer {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TrailerTableViewCell
            cell.video = presenter?.video(at: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieListTableViewCell
            cell.isLoading = false
            cell.item = presenter?.discoverItem(at: indexPath)
            presenter?.loadPosterImage(cell.posterImage, at: indexPath)
            cell.tableViewProtocol = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
}

// MARK: - UITableViewDelegate -

extension MovieDetailListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         if detailContent == .trailer {
            presenter?.didSelectTrailer(at: indexPath)
         } else if detailContent == .related {
            navigationController?.delegate = nil
            presenter?.didSelectRelatedMovie(at: indexPath)
        }
    }
    
}

// MARK: - AddMoviesTableViewProtocol -

extension MovieDetailListViewController: AddMoviesTableViewProtocol {
    
    func touchAddMovie(from row: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: row) {
           presenter?.addMovie(indexPath: indexPath)
        }
    }
    
}

// MARK: - UIViewControllerPreviewingDelegate -

extension MovieDetailListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard
            let indexPath = tableView.indexPathForRow(at: location),
            let presenter = presenter
        else { return nil }
        previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
        let detailVC = MovieListCellDetailViewController.newInstance(addProtocol: presenter, indexPath: indexPath)
        return detailVC
    }
    
}

