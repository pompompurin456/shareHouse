//
//  File.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/10.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import UIKit

final class NameCell: UITableViewCell, CellReusable {
    @IBOutlet weak var nameLavel: UILabel!
    @IBOutlet weak var numberLavel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(name: String, number: String) {
        nameLavel.text = name
        numberLavel.text = number
    }
}
