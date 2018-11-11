////
////  MoviesProtocol.swift
////  Movs
////
////  Created by João Gabriel Borelli Padilha on 10/11/18.
////  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
////
//
//import UIKit
//
//// To View
//protocol UserPresenterToViewProtocol: class {
//    func showUser(username: String, email: String, imageURL: String)
//    func showUserPhotos(images: [ImageContent])
//}
//
//// To Presenter
//protocol UserInterectorToPresenterProtocol {
//    func fetchUser(with data: DataUser)
//    func fetchUserPhotos(images: [ImageContent])
//    func logout(status: Bool)
//}
//
//protocol UserViewToPresenterProtocol: class {
//    var view: UserPresenterToViewProtocol? {get set}
//    var interector: UserPresentorToInterectorProtocol? {get set}
//    var router: UserPresenterToRouterProtocol? {get set}
//    func viewDidLoad()
//    func logout()
//}
//
//// To Interactor
//protocol UserPresentorToInterectorProtocol {
//    var presenter: UserInterectorToPresenterProtocol? {get set}
//    func fetchUser()
//    func fetchUserPhotos()
//    func logout()
//}
//
//// To Router
//protocol UserPresenterToRouterProtocol {
//    static func createModule() -> UIViewController
//    func presentLoginScreen(from view: UserPresenterToViewProtocol)
//    func presentApp(from view: UserPresenterToViewProtocol)
//    func presentEnter(from view: UserPresenterToViewProtocol)
//}
