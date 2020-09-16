//
//  RememberItem.swift
//  I Remember
//
//  Created by Stewart Lynch on 2020-09-13.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import Foundation

struct RememberItem: Codable {
    var id = UUID()
    var title: String
    var icon: String
    var detail1: String
    var detail2: String
    var isPrimary = false
}
