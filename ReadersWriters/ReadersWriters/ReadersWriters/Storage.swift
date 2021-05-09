//
//  Storage.swift
//  Readers and Writers
//
//  Created by Alex on 5/9/21.
//

import Foundation

protocol Storage: class {
    func readLast() -> String?
    func removeLast()
    func add(_ string: String)
}

class StorageImpl: Storage {
    
    private var data = [String]()
    private let writeLock = DispatchSemaphore(value: 1)
    private let readersCountLock = DispatchSemaphore(value: 1)
    private var readersCount = 0

    func readLast() -> String? {
        
        var lastString: String? = nil

        readersCountLock.wait()
        readersCount += 1
        if (readersCount == 1) {
            writeLock.wait()
        }
        readersCountLock.signal()
        
        if (data.count > 0) {
            let lastItemIndex = (data.count - 1)
            lastString = data[lastItemIndex]
        }

        readersCountLock.wait()
        readersCount -= 1
        if (readersCount == 0) {
            writeLock.signal()
        }
        readersCountLock.signal()
        
        return lastString
    }
    
    func removeLast() {
        writeLock.wait()
        if data.count > 0 {
            data.removeLast()
        }
        writeLock.signal()
    }
    
    func add(_ string: String) {
        writeLock.wait()
        data.append(string)
        writeLock.signal()
    }

}
