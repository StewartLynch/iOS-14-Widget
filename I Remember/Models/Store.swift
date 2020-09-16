//
//  Store.swift
//  I Remember
//
//  Created by Stewart Lynch on 2020-09-13.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import Foundation

class Store {

    let JSONURL = URL(fileURLWithPath: "RememberItems",
                           relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")

     func loadItems() -> [RememberItem] {
        print(JSONURL)
      let decoder = JSONDecoder()
      var items:[RememberItem] = []

      do {
        let itemData = try Data(contentsOf: JSONURL)
        items = try decoder.decode([RememberItem].self, from: itemData)
      } catch let error {
        print(error)
      }
      return items
    }

       func saveItems(items:[RememberItem]) {
      let encoder = JSONEncoder()

      do {
        let itemData = try encoder.encode(items)
        try itemData.write(to: JSONURL, options: .atomicWrite)
      } catch let error {
        print(error)
      }
    }
}
