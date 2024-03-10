//
//  GetDailyBillsResponse.swift
//  LegisLink
//
//  Created by Mason Cochran on 2/18/24.
//

import Foundation




struct GetDailyBillsResponse: Codable {
    let bills: [Bill]
    let pagination: CongressGovPagination
    let request: GetDailyBillsResponseRequest
}


struct GetDailyBillsResponseRequest: Codable {
    let congress: String
    let contentType: String
    let format: String
}






