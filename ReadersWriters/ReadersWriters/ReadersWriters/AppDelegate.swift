//
//  AppDelegate.swift
//  ReadersWriters
//
//  Created by Alex on 5/9/21.
//  Copyright © 2021 AlexCo. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    private var operations = [OperationPerformer]()
    private let storage: Storage = StorageImpl()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let reader1Perfromer = OperationPerformer(id: 0, storage: storage)
        operations.append(reader1Perfromer)
        
        reader1Perfromer.perform { (storage, id) in
            if let str = storage.readLast() {
                Swift.print("Reader: \(id): \(str)")
            } else {
                Swift.print("Storage empty")
            }
        }
        
        let reader2Perfromer = OperationPerformer(id: 1, storage: storage)
        operations.append(reader2Perfromer)
        
        reader2Perfromer.perform({ (storage, id) in
            if let str = storage.readLast() {
                Swift.print("Reader: \(id): \(str)")
            } else {
                Swift.print("Storage empty")
            }
        })

        
        let addPerformer = OperationPerformer(id: 2, storage: storage)
        operations.append(addPerformer)
        addPerformer.perform({ (storage, id) in
            storage.add("\(Date())")
            Swift.print("Add Performer: \(id):")
        })
        
        
        let removeLastPerfromer = OperationPerformer(id: 3, storage: storage)
        operations.append(removeLastPerfromer)

        removeLastPerfromer.perform({ (storage, id) in
            storage.removeLast()
            Swift.print("Remove Last Performer: \(id)")
        })
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

