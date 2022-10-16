//
//  ViewController.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 06/10/2022.
//

import UIKit
import Combine


class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
          message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
      }
   
}
