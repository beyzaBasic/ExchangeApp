//
//  DBManager.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 11.02.2022.
//

import Foundation
import RealmSwift

class DBManager: NSObject {
    static let shared = DBManager()
    var realm: Realm!
    private let directory = "Realm"

    override private init() {
        super.init()
        self.configureRealm()
    }

    // MARK: - Configure Realm
    private func configureRealm() {
        let dbPath = String.documentsPath.appendPath(self.directory)
        dbPath.createDirectoryIfNotExists()
        let fileURLPath: String = self.realmFileURLPath()
        let fileURL = URL(fileURLWithPath: fileURLPath)
        guard fileURLPath.isFileExistsAtPath() == true else {
            do {
                self.realm = try Realm(configuration: self.realmConfiguration(fileURL: fileURL))
                print("REALM::::::::::Initialized at \(fileURL.absoluteString)")
            } catch {
                print("Realm Error = \(error)")
                self.realm = try! Realm()
            }
            return
        }
        do {
            self.realm = try Realm(configuration: self.realmConfiguration(fileURL: fileURL))
        } catch {
            //LogError("Realm Error = \(error)")
            self.realm = try! Realm()
        }
    }

    private func realmConfiguration(fileURL: URL) -> Realm.Configuration {
        let newVersionNumber: UInt64 = 1
        return Realm.Configuration(fileURL: fileURL, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: newVersionNumber, migrationBlock: { migration, oldVersion in
            DBManager.migrationBlock(object: migration, oldVersion: oldVersion)
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
    }

    private func realmFileURLPath() -> String {
        guard let uuid: String = UIDevice.current.identifierForVendor?.uuidString else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let todayStr: String = formatter.string(from: Date())
            return String.documentsPath
                .appendPath(self.directory)
                .appendPath("exchangeApp\(todayStr)")
                .appendExtension("realm")
        }
        return String.documentsPath
            .appendPath(self.directory)
            .appendPath("exchangeApp\(uuid)")
            .appendExtension("realm")
    }

    // MARK: - Table Accessor

    func getCurrencyResponse() -> CurrencyResponse? {
        let model = Array(DBManager.shared.realm.objects(CurrencyResponse.self)).first
        return model
    }

    func addCurrencyResponse(model: CurrencyResponse, completion: (Bool) -> Void) {
        self.safeAdd(update: nil, with: model, completion: completion)
    }

    func updateCurrencyResponse(model: CurrencyResponse, completion: (Bool) -> Void) {
        self.safeAdd(update: .modified, with: model, completion: completion)
    }

    
    // MARK: - Safe CRUD
    private func safeDelete<T: Object>(object: T, completion: ((Bool) -> Void)) {
        do {
            try DBManager.shared.realm.write {
                DBManager.shared.realm.delete(object)
                completion(true)
            }
        } catch let error {
            print("\(String(describing: type(of: self))):::::>\(#function): Realm \(String(describing: T.description)) commit error. Error: \(error.localizedDescription)")
            completion(false)
        }
    }

    private func safeAdd<T: Object>(update: Realm.UpdatePolicy?, with model: T, completion: ((Bool) -> Void) = { _ in }) {
        if DBManager.shared.realm.isInWriteTransaction {
            try? DBManager.shared.realm.commitWrite()
        }
        do {
            DBManager.shared.realm.beginWrite()
            if model.isInvalidated {
                print("\(String(describing: type(of: self))):::::>\(#function): \(model.description) is invalidated")
                completion(false)
            } else {
                if let updateType = update {
                    DBManager.shared.realm.add(model, update: updateType)
                } else {
                    DBManager.shared.realm.add(model)
                }
                try DBManager.shared.realm.commitWrite()
                completion(true)
            }
        } catch {
            print("\(String(describing: type(of: self))):::::>\(#function): Realm \(model.description) commit error")
            completion(false)
        }
    }
}

// MARK: - Migrations
extension DBManager {
    private static func migrationBlock(object: Migration, oldVersion: UInt64) {

    }
}

