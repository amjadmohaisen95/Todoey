//
//  Category.swift
//  Todoey
//
//  Created by Mohammad Mohaisen on 12/15/18.
//  Copyright © 2018 amjad Mohaisen. All rights reserved.
//

import Foundation
import RealmSwift


class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
