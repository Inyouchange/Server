//
//  TodoQuery.swift
//  1005
//
//  Created by Betty on 05/10/2018.
//

import Foundation
import KituraContracts

struct TodosQuery: QueryParams {
    let id: Int?
    let title: String?
    let order: Ordering?
}


