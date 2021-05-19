//
//  ViewController.swift
//  BitcoinCurrency
//
//  Created by Ted Motta on 18/05/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK:- Variáveis
    
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var bitcoinValueLabel: UILabel!
    
    //MARK:- Constantes
    let apiKey = "YThjODc2Y2IzOTM1NGE2YmJiYjA0NDZkNjhjNTQ5ZDQ"
    let curruncies : [String] = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let baseUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCAUD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        fetchData(url: baseUrl)
        // Do any additional setup after loading the view.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return curruncies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            // retorna o titulo para a selacao
            return curruncies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var url = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC\(curruncies[row])"
        fetchData(url: url)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
              return 1
    }
    
    func converterDoubleToCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    
    func fetchData(url: String) {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "x-ba-key")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                self.parseJSON(json: data)
            } else {
                // Dados não encontrados
                print("error")
            }
        }
        task.resume()
    }
    
    func parseJSON(json: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: json, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    
                    if let askValue = json["ask"] as? NSNumber {
                        
                        print(askValue)
         
                        //let askvalueString = ("\(askValue)")
                        DispatchQueue.main.async {
                            self.bitcoinValueLabel.text = self.converterDoubleToCurrency(amount: Double(truncating: askValue))
                        }
                    print("success")
                    } else {
                        print("error")
                    }
                }
            }
            catch {
                print("error parsing json: \(error)")
            }
    }
}
