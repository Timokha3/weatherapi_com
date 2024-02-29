//
//  DataProviderService.swift
//  Weather_Swift
//
//  Created by Timur on 23.02.2024.
//

import Foundation

/*
protocol DataProviderProtocol {
    func getObjects<T: Object>(completion: @escaping (_ items: [T]) -> Void)
    func saveObjects<T: Object>(_ items: [T])
    func deleteObjects<T: Object>(_ items: T)
    func deleteObject<T: Object>(_ item: T)
}

final class DataProviderService: DataProviderProtocol {
    
    static let shared = DataProviderService()
    
    func getObjects<T: Object>(completion: @escaping (_ items: [T]) -> Void) {
        var items = [T]()
        do {
            let realm = try Realm()
            print("Realm path:", realm.configuration.fileURL ?? "no url")
            items = Array(realm.objects(T.self))
            DispatchQueue.main.async {
                completion(items)
            }
        } catch {
            print(error)
        }
    }
    
    func saveObjects<T: Object>(_ items: [T]){
        do {
            let realm = try Realm()
            for item in items {
                realm.beginWrite()
                realm.add(item, update: .all)
                try realm.commitWrite()
            }
        } catch {
            print(error)
        }
    }
    
    func deleteObjects<T: Object>(_ items: T) {
        do {
            let realm = try Realm()
            let oldItem = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldItem)
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
    }
    
    func saveObject<T: Object>(_ item: T){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteObject<T: Object>(_ item: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
*/
