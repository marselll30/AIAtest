//
//  SecondPage.swift
//  AIA iOS App Showcase
//
//  Created by Marsel Estefan Lie on 13/04/21.
//

import UIKit

class SecondPage: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var symbolSearch: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        symbolSearch.delegate = self
        // Do any additional setup after loading the view.
    }
    
    var apiManager = APIDaily()
//    var timeArray: [String] = []
//    var openArray: [String] = []
//    var lowArray: [String] = []
    var stockArray: [String] = []
    var openArray: [String] = []
    var lowArray: [String] = []
}

extension SecondPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        cell.textLabel?.text = "\(timeArray[indexPath.row])"
        cell.textLabel?.text = "\(stockArray[indexPath.row])                  \(openArray[indexPath.row])                \(lowArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Stock               Open                      Low"
    }
    
}

extension SecondPage: UITextFieldDelegate {
    @IBAction func searchTapped(_ sender: Any) {
        symbolSearch.endEditing(true)
        print(symbolSearch.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        symbolSearch.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let symbol = symbolSearch.text {
            apiManager.fetchSymbol(symbolName: symbol)
        }
    }
}


extension SecondPage: DailyDelegate {
    func didUpdateAPI(_ apiManger: APIDaily, api: APIModel) {
        DispatchQueue.main.async {
//            self.timeArray.append(contentsOf: api.timesArray)
            self.dateLabel.text = api.time
            self.openArray.append(api.open)
            self.stockArray.append(api.symbol)
            self.lowArray.append(api.low)
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
