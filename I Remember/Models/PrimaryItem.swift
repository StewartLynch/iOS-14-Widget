//
//  PrimaryItem.swift
//  I Remember
//
//  Created by Stewart Lynch on 2020-09-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI
import WidgetKit

@available(iOS 14, *)
struct PrimaryItem {
    @AppStorage("rememberItem", store: UserDefaults(suiteName: "group.com.createchsol.IRemember")) var primaryItemData: Data = Data()
    let primaryItem: RememberItem
    
    func storeItem() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(primaryItem) else {
            print("Could not encode data")
            return
        }
        primaryItemData = data
        WidgetCenter.shared.reloadAllTimelines()
        print(String(decoding: primaryItemData, as: UTF8.self))
    }
    
}
