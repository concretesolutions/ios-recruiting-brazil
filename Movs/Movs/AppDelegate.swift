//
//  AppDelegate.swift
//  Movs
//
//  Created by Gustavo Caiafa on 14/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit
import Connectivity
import ObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate let connectivity: Connectivity = Connectivity()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let bancoInstalado = UserDefaults.standard.bool(forKey: "Database")
        if(!bancoInstalado){
            if(Database.instance.criarTabelaMovie()){
                UserDefaults.standard.set(true, forKey: "Database")
            }
        }
        
        verificaConexao()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Tenamos pegar os generos uma vez para usar em todo o app. Caso de erro, tentamos novamente.
    // Caso o erro persista, pegaremos na tela de detalhe do filme.
    func getGenres(status : Connectivity.Status, isFirstTime: Bool){
        let parametros = ["api_key" : "1724b8b1c0fd57af003ab0dace8bb4db",
                          "language" : "pt-BR"] as [String : AnyObject]
        Service.callMethodJson(metodo: .get, parametros: parametros, url: Service.LinksAPI.GetGenres, nomeCache: "Genres", status: status) { (response, error) in
            if(error == nil && response != nil){
                if let genresMap = Mapper<GenreResultModel>().map(JSONObject: response){
                    Utils.Global.genresModel = genresMap
                }
                else{
                    if(isFirstTime){
                        self.getGenres(status: status, isFirstTime: false)
                    }
                    print("Nao mapeou os generos")
                }
            }
            else{
                if(isFirstTime){
                    self.getGenres(status: status, isFirstTime: false)
                }
                print("Erro getGenres : \(String(describing: error?.description))")
            }
        }
    }
    
    func verificaConexao(){
        connectivity.checkConnectivity { resultado in
            print("Resultado conexao: \(resultado.status)")
            self.getGenres(status: resultado.status, isFirstTime: true)
        }
    }


}

