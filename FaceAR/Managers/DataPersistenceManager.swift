//
//  DataPersistenceManager.swift
//  FaceAR
//
//  Created by Fernando Brito on 03/10/23.
//

import CoreData
import UIKit

enum DatabaseError: Error {
    case failedToSaveData
    case failedToFetchData
}

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    func saveSessionData(with model: SavedRecordingSession, completion: @escaping (Result<RecordingSession, Error>) -> Void) {
        // Reference to the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        // What is going to be saved on the data base with the supervision of the context manager
        let item = RecordingSession(context: context)
        
        item.id = model.id
        item.duration = model.duration
        item.tag = model.tag
        
        do {
            try context.save()
            
            completion(.success(item))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchingRecordingsFromDataBase(completion: @escaping (Result<[RecordingSession], Error>) -> Void) {
        // Reference to the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<RecordingSession> = RecordingSession.fetchRequest()
        
        do {
            let recordings = try context.fetch(request)
            
            completion(.success(recordings))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
}
