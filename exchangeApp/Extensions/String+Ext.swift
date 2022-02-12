//
//  String+Ext.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 11.02.2022.
//

import Foundation

// MARK: FileManager Extensions
extension String {

    @discardableResult
    func createDirectoryIfNotExists() -> Bool {
        guard self.isDirectoryExistsAtPath() == false else { return true }
        return self.createDirectory()
    }

    @discardableResult
    private func createDirectory() -> Bool {
        guard self.isDirectoryExistsAtPath() == false else { return true }
        do {
            try FileManager.default.createDirectory(atPath: self, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error {
            print(error.localizedDescription)
        }
        return false
    }
}

// MARK: File Path
extension String {
    static var documentsPath: String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.path
    }

    func appendPath(_ pathComponent: String) -> String {
        var mutableSelf = self
        mutableSelf = (mutableSelf as NSString).appendingPathComponent(pathComponent)
        return mutableSelf
    }

    func appendExtension(_ ext: String) -> String {
        let alphanumeric = CharacterSet.alphanumerics.inverted
        let extensionComponent = ext.components(separatedBy: alphanumeric).joined(separator: "")
       return self + "." + extensionComponent
    }

    func isFileExistsAtPath() -> Bool {
        var isDirectory = ObjCBool(false)
        return FileManager.default.fileExists(atPath: self, isDirectory: &isDirectory)
    }

    func isDirectoryExistsAtPath() -> Bool {
        var isDirectory = ObjCBool(true)
        return FileManager.default.fileExists(atPath: self, isDirectory: &isDirectory)
    }
}

