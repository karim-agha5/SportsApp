//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Karim on 19/05/2023.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var teamsArray: [Team] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        initArray()
    }
    
    private func initArray(){
        let team = Team()
        team.team_name = "Real Madrid"
        for _ in 1...2{
            teamsArray.append(team)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return teamsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? TeamTableViewCell
        
        cell?.setupCell(withTeamName: teamsArray[indexPath.row].team_name ?? "Unknown", andTeamImageUrl: teamsArray[indexPath.row].team_logo ?? "")
        
        return cell ?? UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this team?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                // TODO delete team from core data and array here
                self.teamsArray.remove(at: indexPath.row)
                self.favoritesTableView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            alertController.view.tintColor = .red
            
            // Change the tint color of the cancel button to black
            cancelAction.setValue(UIColor.black, forKey: "titleTextColor")
        
            if let cell = tableView.cellForRow(at: indexPath) {
               alertController.popoverPresentationController?.sourceView = cell
               alertController.popoverPresentationController?.sourceRect = cell.bounds
           }
           
           present(alertController, animated: true, completion: nil)
        
        // TODO navigate to teams details
    }
    
    private func handleDeletionAlert(_ tableView: UITableView, indexPath: IndexPath){
        
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this team?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                // TODO delete team from core data and array here
                self.teamsArray.remove(at: indexPath.row)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            alertController.view.tintColor = .red
            
            // Change the tint color of the cancel button to black
            cancelAction.setValue(UIColor.black, forKey: "titleTextColor")
        
            if let cell = tableView.cellForRow(at: indexPath) {
               alertController.popoverPresentationController?.sourceView = cell
               alertController.popoverPresentationController?.sourceRect = cell.bounds
           }
           
           present(alertController, animated: true, completion: nil)
    }
    
}
