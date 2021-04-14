//
//  ThirdPage.swift
//  AIA iOS App Showcase
//
//  Created by Marsel Estefan Lie on 14/04/21.
//

import UIKit

class ThirdPage: UIViewController {
    
    @IBOutlet weak var symbolSearch: UITextField!
    @IBOutlet weak var intervalPick: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var stockSymbol: UILabel!
    @IBOutlet weak var timeUpdated: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        pickerView.isHidden = true
        symbolSearch.delegate = self
        intervalPick.delegate = self
        // Do any additional setup after loading the view.
    }
    
    var selectedInterval: String?
    var intervalList = ["1min", "5min", "15min", "30min", "60min"]
    var apiManager = APIIntraday()
    
}

extension ThirdPage: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if intervalPick.isEditing {
            pickerView.isHidden = false
        } else if intervalPick.isEditing == false {
            pickerView.isHidden = true
        }
        
    }
    
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
            apiManager.fetchSymbol(symbolName: symbol, interval: "\(intervalPick.text ?? intervalList[1])", outputsize: "")
        }
    }
    
}


extension ThirdPage: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervalList.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervalList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedInterval = intervalList[row]
        intervalPick.text = selectedInterval
    }
}


extension ThirdPage: IntradayDelegate {
    func didUpdateAPI(_ apiManger: APIIntraday, api: APIModel) {
        DispatchQueue.main.async {
            self.stockSymbol.text = api.symbol
            self.openLabel.text = "\(api.open)"
            self.highLabel.text = "\(api.high)"
            self.lowLabel.text = "\(api.low)"
            self.timeUpdated.text = "\(api.time)"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
