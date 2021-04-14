//
//  ThirdPage.swift
//  AIA iOS App Showcase
//
//  Created by Marsel Estefan Lie on 14/04/21.
//

import UIKit

class ThirdPage: UIViewController {
    
    @IBOutlet weak var symbolSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var intervalPick: UITextField!
    @IBOutlet weak var outputSize: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiManager.delegate = self
        pickerView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    var selectedInterval: String?
    var intervalList = ["1min", "5min", "15min", "30min", "60min"]
    var apiManager = APIIntraday()
    
    func createPickerView() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
           intervalPick.inputView = pickerView
    }
//    func dismissPickerView() {
//       let toolBar = UIToolbar()
//       toolBar.sizeToFit()
//        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
//       toolBar.setItems([button], animated: true)
//       toolBar.isUserInteractionEnabled = true
//       intervalPick.inputAccessoryView = toolBar
//    }
//    @objc func action() {
//          view.endEditing(true)
//    }
    
}

extension ThirdPage: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if intervalPick.isEditing {
            pickerView.isHidden = false
        } else {
            pickerView.isHidden = true
        }
        
    }
    
}


extension ThirdPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
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
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
