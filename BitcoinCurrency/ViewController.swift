//
//  ViewController.swift
//  BitcoinCurrency
//
//  Created by Ted Motta on 18/05/21.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- Variáveis
    
    //MARK:- Constantes
    let apiKey = "YThjODc2Y2IzOTM1NGE2YmJiYjA0NDZkNjhjNTQ5ZDQ"
    let curruncies : [String] = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let baseUrl = "https://apiv2.bitcoinaverage.com/indices/{symbol_set}/ticker/{symbol}"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func fetchData(url: String) {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "x-ba-key")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let data = String(data: data, encoding: .utf8)
            } else {
                // Dados não encontrados
                print("error")
            }
        }
        task.resume()
    }
}

