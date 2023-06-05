//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Karim on 04/06/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AnyTeamDetailsScreen {

    var sportType: String?
    
    var teamId: String?
    
    var teamName: String?
    
    var leagueId: String?
    
    var teamLogo: String?
    
    var isHeartFilled: Bool?
    
    var playersArray: [Player] = []
    
    private let teamDetailsPresenter: AnyTeamDetailsPresenter = TeamDetailsPresenter()
    
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBOutlet weak var ivTeamLogo: UIImageView!
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamDetailsPresenter.attachView(teamDetailsScreen: self)
        playersCollectionView.register(UINib(nibName: "CustomPlayerDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomPlayerDetailsCollectionViewCell")
        playersCollectionView.dataSource = self
        playersCollectionView.delegate = self
        playersCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        loadTeamImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if teamDetailsPresenter.isTeamInFavs(teamKey: teamId ?? "-1") {
            
            isHeartFilled = true
            
            self.btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.btnFavorite.tintColor = UIColor.red
            
            }
        
            else{
                isHeartFilled = false
                self.btnFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
        }

    }
    
    
    private func loadTeamImage(){
        self.ivTeamLogo.sd_setImage(with: URL(string: teamLogo ?? ""), placeholderImage: UIImage(named: "SportImagePlaceholder")!){
            image,error,cacheType,url in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.ivTeamLogo.image = UIImage(named: "SportImagePlaceholder")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.ivTeamLogo.image = image
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomPlayerDetailsCollectionViewCell", for: indexPath) as! CustomPlayerDetailsCollectionViewCell
        cell.setupCell(playerImageUrl: playersArray[indexPath.row].player_image, playerName: playersArray[indexPath.row].player_name, playerAge: playersArray[indexPath.row].player_age)
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.red.cgColor
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.playersCollectionView.frame.height * 0.6
        let width = self.playersCollectionView.frame.width * 0.4
        return CGSize(width: width , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edge = self.playersCollectionView.frame.width * 0.05
        let top = self.playersCollectionView.frame.width * 0.1
        return UIEdgeInsets.init(top: top, left: edge, bottom: 50, right: edge)
    }
    
    
    @IBAction func addToFavorites(_ sender: Any) {
        self.btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        if isHeartFilled! {

            if teamDetailsPresenter.deleteFromFavs(teamKey: teamId ?? "-1") {

                isHeartFilled = false

                self.btnFavorite.setImage(UIImage(systemName: "heart"), for: .normal)

                    }

                } else {

                    if teamDetailsPresenter.insertToFavs(sportType, teamId ?? "-1", teamName ?? "Unknown", teamLogo, leagueId ?? "-1"){
                                                        
                        isHeartFilled = true

                        self.btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        self.btnFavorite.tintColor = UIColor.red

            }
        }
    }
    
}
