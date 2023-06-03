//
//  BasketballViewController.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import UIKit
import SDWebImage

class BasketballViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AnyBasketballScreen {

    private var basketballPresenter: AnyBasketballPresenter = BasketballPresenter()
    private var leaguesArray = [League]()
    
    @IBOutlet weak var basketballTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basketballPresenter.attachView(basketballScreen: self)
        getRemoteLeagues()
        basketballTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        basketballTableView.dataSource = self
        basketballTableView.delegate = self
    }
    
    private func getRemoteLeagues(){
        basketballPresenter.getRemoteBasketballLeagues(onComplete: storeLeaguesAsDictionaryLocally){
            DispatchQueue.main.async {
                self.basketballTableView.reloadData()
            }
        }
    }
    
    func storeLeaguesAsDictionaryLocally(remoteLeaguesList: Array<Dictionary<String,Any>>){
        for i in remoteLeaguesList {
            storeLeaguesLocallyInArray(leaguesDictionary: i)
        }
    }
    
    private func storeLeaguesLocallyInArray(leaguesDictionary: Dictionary<String,Any>){
        let leagueName: String = leaguesDictionary["league_name"] as! String
        var leagueKey: Int?
        let league = League()
    
        league.title = leagueName
        league.image = "SportImagePlaceholder"
        
        if leaguesDictionary["league_key"] != nil {
            leagueKey = leaguesDictionary["league_key"] as? Int
            league.league_key = leagueKey
        }
        leaguesArray.append(league)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? TeamTableViewCell
        
        if leaguesArray.count > 0{
         
            cell?.setupCell(withTeamName: self.leaguesArray[indexPath.item].title ?? "Unknow", andTeamImage: UIImage(named: self.leaguesArray[indexPath.item].image ?? "")!)
            
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        leagueDetailsViewController.leagueId = leaguesArray[indexPath.item].league_key ?? -1
        leagueDetailsViewController.type = Constants.BASKETBALL
        navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }
}
