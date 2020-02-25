//
//  Result.swift
//  shareHouse
//
//  Created by 奥田竜矢 on 2020/02/14.
//  Copyright © 2020 okuda ryuya. All rights reserved.
//

import Foundation

public extension Result {
    init(_ success: Success?, _ failure: Failure?) {
        if let success = success {
            self = .success(success)
        } else if let failure = failure {
            self = .failure(failure)
        } else {
            fatalError("Illegal combination found.\n Success: \(success as Any), Failure: \(failure as Any)")
        }
    }
}
