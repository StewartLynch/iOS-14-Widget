//
//  RememberItemsDataSource.swift
//  I Remember
//
//  Created by Stewart Lynch on 2020-09-13.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import UIKit

class RememberItemsDataSource: NSObject {
    let store = Store()
    var rememberItems:[RememberItem]
    
    override init() {
        // Load Items from Storage
        self.rememberItems = store.loadItems()
    }
    
    func newItem(item: RememberItem) {
        rememberItems.append(item)
        // Store Items
        store.saveItems(items: rememberItems)
    }
    
    func updateItem(item: RememberItem, completion: (IndexPath) -> Void) {
        let foundIndex = rememberItems.firstIndex {$0.id == item.id}
        if let foundIndex = foundIndex {
            rememberItems[foundIndex] = item
            // Store Items
            store.saveItems(items: rememberItems)
            let indexPath = IndexPath.init(item: foundIndex, section: 0)
            if item.isPrimary {
                savePrimary(item: item)
            }
            completion(indexPath)
        }
    }
    
    func savePrimary(item: RememberItem) {
        if #available(iOS 14, *) {
            let newPrimary = PrimaryItem(primaryItem: item)
            newPrimary.storeItem()
        }
    }

    func switchPrimary(item: RememberItem, completion: ([IndexPath]) -> Void) {
        var indexPaths:[IndexPath] = []
        let oldIndex = rememberItems.firstIndex { $0.isPrimary}
        if let oldIndex = oldIndex {
            rememberItems[oldIndex].isPrimary = false
            let oldIndexPath = IndexPath.init(item: oldIndex, section: 0)
            indexPaths.append(oldIndexPath)
            let newIndex = rememberItems.firstIndex { $0.id == item.id }
            if let newIndex = newIndex {
                let newIndexPath = IndexPath.init(item: newIndex, section: 0)
                indexPaths.append(newIndexPath)
            }
            // Store Items
            store.saveItems(items: rememberItems)
            completion(indexPaths)


        }
    }
    
    func deleteItem(item: RememberItem, completion: (IndexPath) -> Void) {
        let foundIndex = rememberItems.firstIndex {$0.id == item.id}
        if let foundIndex = foundIndex {
            rememberItems.remove(at: foundIndex)
            // Store Items
            store.saveItems(items: rememberItems)
            let indexPath = IndexPath.init(item: foundIndex, section: 0)
            completion(indexPath)
        }
    }
}

extension RememberItemsDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rememberItems.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RememberItCell
        cell.item = rememberItems[indexPath.item]
        return cell
        
    }
    
    
}
