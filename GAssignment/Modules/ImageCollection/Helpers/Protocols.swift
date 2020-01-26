//
//  Protocols.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/26/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}
