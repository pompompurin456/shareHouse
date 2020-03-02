//
//  NibLoadable.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/26.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation
import UIKit

public protocol CellReusable: NSObjectProtocol {
    static var reuseIdentifier: String { get }
}

public extension CellReusable {
    static var reuseIdentifier: String {
        return Self.className
    }
}

public typealias ReusableTableCell = UITableViewCell & CellReusable
public extension UITableView {
    func register<T: ReusableTableCell>(cellType: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: ReusableTableCell>(cellType: [T.Type]) {
        cellType.forEach { register(cellType: $0) }
    }

    func dequeueReusableCell<T: ReusableTableCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.className) as! T
    }

    func cellForRow<T: ReusableTableCell>(at indexPath: IndexPath, cellType: T) -> T {
        return cellForRow(at: indexPath) as! T
    }
}
