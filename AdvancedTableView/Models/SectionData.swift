//
//  SectionData.swift
//  AdvancedTableView
//
//  Created by Nikita Popov on 21.03.2021.
//

import UIKit

struct SectionData {
    var open: Bool
    var data: [CellData]
}

struct CellData {
    var title: String
    var image: UIImage
}
