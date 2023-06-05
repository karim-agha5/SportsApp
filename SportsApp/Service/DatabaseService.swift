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
    
    static let shared = DatabaseService()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private lazy var context = appDelegate.persistentContainer.viewContext
    
    private init() {}
    
    func insertToFavs(sportType: String?, teamId: String, teamName: String, teamLogo: String?, leagueId: String?) -> Bool{
            let favsEntity = NSEntityDescription.entity(forEntityName: favEntity, in: context)
            let mangaedObject = NSManagedObject(entity: favsEntity!, insertInto: context)
            
            mangaedObject.setValue(teamId, forKey: "teamId")
            mangaedObject.setValue(teamName, forKey: "name")
            mangaedObject.setValue(teamLogo, forKey: "image")
            mangaedObject.setValue(sportType, forKey: "sportType")
            mangaedObject.setValue(leagueId, forKey: "leagueId")
            
            do {
                try context.save()
                return true
            } catch let error as NSError {
                print("Unable to insert teams - \(error.localizedDescription)")
                return false
        }
    }
    
    func deleteFromFavs(teamKey: String) -> Bool{
        
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "teamId == %@", teamKey)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            
            if !fetchedResults.isEmpty {
                for result in fetchedResults {
                    context.delete(result)
                }
                
                try context.save()
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Unable to delete a team - \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchFavs() -> [TeamEntity]? {
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch let error as NSError {
            print("Unable to fetch data - \(error.localizedDescription)")
            return nil
        }
    }
    
    func isTeamInFavs(teamKey: String) -> Bool {
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "teamId == %@",teamKey)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count != 0
        } catch let error as NSError {
            print("Unable to fetch teams - \(error.localizedDescription)")
            return false
        }
    }
}
