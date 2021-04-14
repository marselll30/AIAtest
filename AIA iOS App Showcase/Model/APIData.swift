//
//  APIData.swift
//  AIA iOS App Showcase
//
//  Created by Marsel Estefan Lie on 12/04/21.
//

import Foundation

struct StockIntraday: Codable {
    let metaData: MetaData
    let timeSeries: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries = "Time Series (5min)"
    }
}

struct StockDaily: Codable {
    let metaData: MetaData
    let dateSeries: [String: DateSeries]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case dateSeries = "Time Series (Daily)"
    }
}

struct MetaData: Codable {
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct TimeSeries: Codable {
    let open: String
    let high: String
    let low: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
    }
}


struct DateSeries: Codable {
    let open: String
    let high: String
    let low: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
    }
}
