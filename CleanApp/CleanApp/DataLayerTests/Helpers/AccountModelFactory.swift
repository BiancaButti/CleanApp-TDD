//
//  AccountModelFactory.swift
//  DataLayerTests
//
//  Created by Bianca on 30/08/23.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(id: "any_id",
                        name: "Bianca",
                        email: "bianca@mail.com",
                        password: "123456"
    )
}
