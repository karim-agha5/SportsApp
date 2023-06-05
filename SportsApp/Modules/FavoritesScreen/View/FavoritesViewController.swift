//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Karim on 19/05/2023.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    private let favoritesPresenter: FavoritesPresenter = FavoritesPresenter()
    private var teamsArray: [TeamEntity] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        initArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initArray() // Because viewDidLoad() is called only once.
    }
    
    private func initArray(){
        teamsArray = favoritesPresenter.fetchFavs() ?? []
        favoritesTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return teamsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? TeamTableViewCell
        
        cell?.setupCell(withTeamName: teamsArray[indexPath.row].name ?? "Unknown", andTeamImageUrl: teamsArray[indexPath.row].image ?? "")
        
        return cell ?? UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO navigate to teams details
        let teamDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
        teamDetailsViewController.teamId = "\(teamsArray[indexPath.row].teamId ?? "-1")"
        teamDetailsViewController.leagueId = teamsArray[indexPath.row].leagueId
        teamDetailsViewController.playersArray = []
        teamDetailsViewController.sportType = teamsArray[indexPath.row].sportType
        teamDetailsViewController.teamName = teamsArray[indexPath.row].name
        teamDetailsViewController.teamLogo = teamsArray[indexPath.row].image
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
        print("I'm being clicked!")
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Deleting \(teamsArray[indexPath.row].name ?? "Unknown")", message: "Are you sure you want to delete this team?", preferredStyle: .alert)
                
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                    self.favoritesPresenter.deleteFromFavs(teamKey: self.teamsArray[indexPath.row].teamId!)
                    self.teamsArray.remove(at: indexPath.row)
                    self.favoritesTableView.reloadData()
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alertController.addAction(deleteAction)
                alertController.addAction(cancelAction)
                
                alertController.view.tintColor = .red
                
                cancelAction.setValue(UIColor.black, forKey: "titleTextColor")
            
                if let cell = tableView.cellForRow(at: indexPath) {
                   alertController.popoverPresentationController?.sourceView = cell
                   alertController.popoverPresentationController?.sourceRect = cell.bounds
               }
               
               present(alertController, animated: true, completion: nil)
        }
    }
}
