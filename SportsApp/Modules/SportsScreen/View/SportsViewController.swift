//
//  ViewController.swift
//  SportsApp
//
//  Created by Karim on 19/05/2023.
//

import UIKit

class SportsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    private var sports: [Sport] = []
    
    
    
    
    
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sports"
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        sportsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        initSportsArray()
    }

    private func initSportsArray(){
        sports.append(Sport(title: "Football",image: UIImage(named:"FootballImage")!))
        sports.append(Sport(title: "Basketball",image: UIImage(named:"BasketballImage")!))
        sports.append(Sport(title: "Cricket",image: UIImage(named:"CricketImage")!))
        sports.append(Sport(title: "Tennis",image: UIImage(named:"TennisImage")!))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCollectionViewCell", for: indexPath) as! SportsCollectionViewCell
        cell.initCell(sport: sports[indexPath.item])
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 50, left: 15, bottom: 50, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let footballViewController = storyboard?.instantiateViewController(withIdentifier: "FootballViewController") as! FootballViewController
        
        let basketballViewController = storyboard?.instantiateViewController(withIdentifier: "BasketballViewController") as! BasketballViewController
        
        let tennisViewController = storyboard?.instantiateViewController(withIdentifier: "TennisViewController") as! TennisViewController
        
        let cricketViewController = storyboard?.instantiateViewController(withIdentifier: "CricketViewController") as! CricketViewController
        
        switch(indexPath.item){
        case 0: navigationController?.pushViewController(footballViewController, animated: true)
        case 1: navigationController?.pushViewController(basketballViewController, animated: true)
        case 2: navigationController?.pushViewController(cricketViewController, animated: true)
        default: navigationController?.pushViewController(tennisViewController, animated: true)
        }
    }

}

