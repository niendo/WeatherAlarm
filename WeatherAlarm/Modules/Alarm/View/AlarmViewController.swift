//
//  AlarmViewController.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import UIKit

protocol AlarmViewControllerInterface: BaseViewControllerInterface {
    func makeError(title: String, error: String)
}

class AlarmViewController: BaseViewController {
    
    @IBOutlet var updateLabel: UILabel!
    
    private var time: Date?
    
    let presenter: AlarmPresenterInterface?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(nibName: String, bundle: Bundle?, presenter: AlarmPresenterInterface?) {
        self.presenter = presenter != nil ? presenter : nil
        super.init(nibName: nibName, bundle: bundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        super.viewDidLoad()
        updateUI()
    }
    
    
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        return formatter
    }()
    
    func fetch(_ completion: @escaping (Bool,Error?) -> Void) {
        
        guard let url = URL(string: EnvironmentConstants.weatherApiUrl) else {
            completion(false, nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard nil == err else {
                completion(false, err)
                return
            }
            
            guard let data = data else {
                completion(false, nil)
                return
            }
            
            do {
                

//                if let userOutput = Mapper<WeatherNetwork>().map(JSONObject
//                    : response) {
//                    
//                    
//                } else {
//                }
                
                //                let downloadedCurrencies = try JSONDecoder().decode([WeatherModel].self, from: data)
                
                // Adding downloaded data into Local Array
                
                completion(true, nil)
            } catch let jsonErr {
                print("Here! Error serializing json", jsonErr)
                completion(false,jsonErr)
            }
            
            }.resume()
        
    }
    
    func updateUI() {
        guard updateLabel != nil  else {
            return
        }
        
        if let time = time {
            updateLabel.text = dateFormatter.string(from: time)
        } else {
            updateLabel.text = "Not yet updated"
        }
    }
    
    
    //    @IBAction func didTapUpdate(_ sender: UIButton) {
    //        fetch {_,_  [weak self] in
    //            guard let self = self else { return }
    //            self.updateUI()
    //        }
    //    }
}

extension AlarmViewController: AlarmViewControllerInterface {
    func makeError(title: String, error: String) {
        
    }
    
    
}
