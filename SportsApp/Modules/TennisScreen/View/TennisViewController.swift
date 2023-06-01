//
//  TennisViewController.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import UIKit

class TennisViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AnyTennisScreen {

    private var tennisPresenter: AnyTennisPresenter = TennisPresenter()
    private var leaguesArray = [League]()
    
    @IBOutlet weak var tennisTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tennisPresenter.attachView(tennisScreen: self)
        getRemoteLeagues()
        tennisTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tennisTableView.dataSource = self
        tennisTableView.delegate = self
    }
    
    private func getRemoteLeagues(){
        tennisPresenter.getRemoteTennisLeagues(onComplete: storeLeaguesAsDictionaryLocally){
            DispatchQueue.main.async {
                self.tennisTableView.reloadData()
            }
        }
    }
    
    func storeLeaguesAsDictionaryLocally(remoteLeaguesList: Array<Dictionary<String,Any>>){
        DispatchQueue.global().async {
            for i in remoteLeaguesList {
                self.storeLeaguesLocallyInArray(leaguesDictionary: i)
            }
        }
    }
    
    private func storeLeaguesLocallyInArray(leaguesDictionary: Dictionary<String,Any>){
        let leagueName: String = leaguesDictionary["league_name"] as! String
        let league = League()
    
        league.title = leagueName
        league.image = "SportImagePlaceholder"
        
        leaguesArray.append(league)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? TeamTableViewCell
        
        if leaguesArray.count > 0{
         
            cell?.setupCell(withTeamName: self.leaguesArray[indexPath.item].title ?? "Unknown", andTeamImage: UIImage(named: self.leaguesArray[indexPath.item].image ?? "")!)
            
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }

}
