//
//  DBManager.swift
//  NotesCFT
//
//  Created by Кирилл Зубков on 04.02.2024.
//

import Foundation
import RealmSwift

class DBManager {
    
    // MARK: - Properties
    
    static let sharedInstance = DBManager()
    
    private let realm: Realm
    
    
    // MARK: - Init
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Realm инициализирован с ошибкой: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Interface
    
    func add(note: Note) {
        do {
            try realm.write {
                realm.add(note)
            }
        } catch {
            print("Произошла ошибка при записи в realm: \(error.localizedDescription)")
        }
    }
    
    func edit(note: Note, newText: String) {
        do {
            try realm.write {
                note.text = newText
            }
        } catch {
            print("Произошла ошибка при записи в realm: \(error.localizedDescription)")
        }
    }
    
    func getNotes() ->  Results<Note> {
        let results: Results<Note> = realm.objects(Note.self)
        return results
    }
    
    func remove(note: Note) {
        do {
            try realm.write {
                realm.delete(note)
            }
        } catch {
            print("Произошла ошибка при удалении в realm: \(error.localizedDescription)")
        }
    }
    
}
