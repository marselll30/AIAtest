//
//  ViewController.swift
//  AIA iOS App Showcase
//
//  Created by Marsel Estefan Lie on 12/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var symbolSearch: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        apiManager.delegate = self
        symbolSearch.delegate = self
    }
    var apiManager = APIIntraday()
    
    @IBAction func nextPageTapped(_ sender: Any) {
        
    }
}

extension ViewController: UITextFieldDelegate {
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

extension ViewController: IntradayDelegate {
    func didUpdateAPI(_ apiManger: APIIntraday, api: APIModel) {
        DispatchQueue.main.async {
            self.symbolLabel.text = api.symbol
            self.openLabel.text = "\(api.open)"
            self.highLabel.text = "\(api.high)"
            self.lowLabel.text = "\(api.low)"
            self.timeLabel.text = "\(api.time)"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
