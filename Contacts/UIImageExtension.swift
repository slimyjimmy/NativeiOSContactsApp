//
//  UIImageExtension.swift
//  Contacts
//
//  Created by Djimon Nowak on 14.07.20.
//  Copyright © 2020 Djimon Nowak. All rights reserved.
//

import UIKit
extension UIImage {
    func save() -> String {
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        if !FileManager.default.fileExists(atPath: documentsDirectory.absoluteString) {
//            do {
//                try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: documentsDirectory.absoluteString), withIntermediateDirectories: true, attributes: nil)
//            } catch {
//                print(error)
//            }
//        }
//        if let data = self.pngData() {
//            let fileName = documentsDirectory.appendingPathComponent(Date().description + ".png")
//            do {
//                try data.write(to: fileName)
//            } catch {
//                print("i dunno")
//            }
//            return fileName.absoluteString
//        }
//        return ""
        let directoryPath =  NSHomeDirectory().appending("/Documents/")
        if !FileManager.default.fileExists(atPath: directoryPath) {
            do {
                try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"

        let filename = dateFormatter.string(from: Date()).appending(".jpg")
        let filepath = directoryPath.appending(filename)
        let url = NSURL.fileURL(withPath: filepath)
        do {
            try self.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
            //return String.init("/Documents/\(filename)")
            return url.path
        } catch {
            print(error)
            print("file cant not be save at path \(filepath), with error : \(error)");
            return filepath
        }
    }
}
