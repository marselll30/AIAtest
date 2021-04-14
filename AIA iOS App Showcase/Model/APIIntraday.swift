//
//  APIManager.swift
//  AIA iOS App Showcase
//
//  Created by Marsel Estefan Lie on 12/04/21.
//

import Foundation

protocol IntradayDelegate {
    func didUpdateAPI(_ apiManger: APIIntraday, api: APIModel)
    func didFailWithError(error: Error)
}

struct APIIntraday {
    let intradayUrl = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&apikey=NQ86V61P3PX60636"
    
    var delegate: IntradayDelegate?
    
    func fetchSymbol(symbolName: String) {
        let urlString = "\(intradayUrl)&symbol=\(symbolName)&interval=5min"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let api = self.parseJSON(safeData) {
                        self.delegate?.didUpdateAPI(self, api: api)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ apiData: Data) -> APIModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(StockIntraday.self, from: apiData)
            let times = decodedData.timeSeries.keys
            let time = times.first
            let timeArr = decodedData.timeSeries.keys.map({$0})
            let symbol = decodedData.metaData.symbol
            let open = decodedData.timeSeries[time!]?.open
            let high = decodedData.timeSeries[time!]?.high
            let low = decodedData.timeSeries[time!]?.low
            
            let api = APIModel(symbol: symbol, open: open!, high: high!, low: low!, time: time!, timesArray: timeArr)
            return api
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}



protocol DailyDelegate {
    func didUpdateAPI(_ apiManger: APIDaily, api: APIModel)
    func didFailWithError(error: Error)
}

struct APIDaily {
    let dailyUrl = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&apikey=NQ86V61P3PX60636"
    
    var delegate: DailyDelegate?
    
    func fetchSymbol(symbolName: String) {
        let urlDailyString = "\(dailyUrl)&symbol=\(symbolName)"
        performRequest(with: urlDailyString)
    }
    
    func performRequest(with urlDailyString: String) {
        
        if let url = URL(string: urlDailyString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let api = self.parseJSON(safeData) {
                        self.delegate?.didUpdateAPI(self, api: api)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ apiData: Data) -> APIModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(StockDaily.self, from: apiData)
            let times = decodedData.dateSeries.keys
            let time = times.first
            let timeArr = decodedData.dateSeries.keys.map({$0})
            let symbol = decodedData.metaData.symbol
            let open = decodedData.dateSeries[time!]?.open
            let high = decodedData.dateSeries[time!]?.high
            let low = decodedData.dateSeries[time!]?.low
            
            let api = APIModel(symbol: symbol, open: open!, high: high!, low: low!, time: time!, timesArray: timeArr)
            return api
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
