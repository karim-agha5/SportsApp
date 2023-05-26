//
//  FootballViewController.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import UIKit
import SDWebImage

class FootballViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AnyFootballScreen {
    
    private var leaguesArray = [League]()
    private var footballPresenter: AnyFootballPresenter = FootballPresenter()
    
    @IBOutlet weak var footballTeamsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footballPresenter.attachView(footballScreen: self)
        getRemoteLeagues()
        footballTeamsTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        footballTeamsTableView.dataSource = self
        footballTeamsTableView.delegate = self
    }

    private func getRemoteLeagues(){
        footballPresenter.getRemoteFootballLeagues(onComplete: storeLeaguesAsDictionaryLocally){
            DispatchQueue.main.async {
                self.footballTeamsTableView.reloadData()
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
        var leagueLogo: String?
        let league = League()
        
        league.title = leagueName
        if leaguesDictionary["league_logo"] != nil{
            leagueLogo = leaguesDictionary["league_logo"] as? String
            league.image = leagueLogo ?? "SportImagePlaceholder"
        }
        else{
            league.image = "SportImagePlaceholder"
        }
        leaguesArray.append(league)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? TeamTableViewCell
        
        if leaguesArray.count > 0{
            SDWebImageDownloader.shared.downloadImage(with: URL(string: leaguesArray[indexPath.item].image), progress: nil){
                (image, _, _, _) in
                       if let _ = image {
                           cell?.setupCell(withTeamName: self.leaguesArray[indexPath.item].title, andTeamImage: image!)
                }
            }
            
        }
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }
}
