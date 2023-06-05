//
//  DatabaseService.swift
//  SportsApp
//
//  Created by Karim on 05/06/2023.
//

import Foundation
import UIKit
import CoreData

class DatabaseService {
    private let favEntity = "TeamEntity"
  //  private let leagueEntity = "LeaguesDB"
    
    static let shared = DatabaseService()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var context = appDelegate.persistentContainer.viewContext
    
    private init() {}
    
    func insertToFavs(_ sportType: String?, _ teamId: String, _ teamName: String, _ teamLogo: String?, _ leagueId: String?) -> Bool {
       // if isFavoriteDb{
            let favsEntity = NSEntityDescription.entity(forEntityName: favEntity, in: context)
            let mangaedObject = NSManagedObject(entity: favsEntity!, insertInto: context)
            
           // mangaedObject.setValue(Int64(teamId), forKey: "teamId")
            mangaedObject.setValue(teamId, forKey: "teamId")
            mangaedObject.setValue(teamName, forKey: "name")
            mangaedObject.setValue(teamLogo, forKey: "image")
            mangaedObject.setValue(sportType, forKey: "sportType")
            mangaedObject.setValue(leagueId, forKey: "leagueId")
            
            do {
                try context.save()
                print("Success insert")
                return true
            } catch let error as NSError {
                print(error.localizedDescription)
                return false
        //    }
        }/*else{
            let leaguesEntity = NSEntityDescription.entity(forEntityName: leagueEntity, in: context)
            let mangaedObject = NSManagedObject(entity: leaguesEntity!, insertInto: context)
            
            mangaedObject.setValue(Int64(teamKey), forKey: "id")
            mangaedObject.setValue(teamName, forKey: "league_name")
            mangaedObject.setValue(Int64(sportId!), forKey: "sport_id")
            
            do {
                try context.save()
                print("Success insert")
                return true
            } catch let error as NSError {
                print(error.localizedDescription)
                return false
            }
        }
        */
    }
    
    func deleteFromFavs(teamKey: String) -> Bool {
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
       // fetchRequest.predicate = NSPredicate(format: "teamId == %d", Int64(teamKey))
        fetchRequest.predicate = NSPredicate(format: "teamId == %@", teamKey)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            
            if !fetchedResults.isEmpty {
                for result in fetchedResults {
                    context.delete(result)
                }
                
                try context.save()
                print("Successfully deleted data.")
                return true
            } else {
                print("No matching data found.")
                return false
            }
        } catch let error as NSError {
            print("Failed to delete data: \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchFavs() -> [TeamEntity]? {
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch let error as NSError {
            print("Failed to fetch data: \(error.localizedDescription)")
            return nil
        }
    }
  /*
    func fetchLeagues(_ sportId: Int) -> [LeaguesDB]? {
        let fetchRequest: NSFetchRequest<LeaguesDB> = LeaguesDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "sport_id == %d", sportId)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch let error as NSError {
            print("Failed to fetch data from leagues: \(error.localizedDescription)")
            return nil
        }
    }
    */
    
    func isTeamInFavs(teamKey: String) -> Bool {
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "teamId == %d", Int64(teamKey))
        fetchRequest.predicate = NSPredicate(format: "teamId == %@",teamKey)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count != 0
        } catch let error as NSError {
            print("Failed to fetch team: \(error.localizedDescription)")
            return false
        }
    }
}
