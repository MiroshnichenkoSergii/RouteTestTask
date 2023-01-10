//
//  Alert.swift
//  RouteTestTask
//
//  Created by Sergii Miroshnichenko on 10.01.2023.
//

import UIKit

extension UIViewController {
    
    func alertAddAdress(title: String, placeholder: String, completionHandler: @escaping (String) -> ()) {
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let tfText = ac.textFields?.first
            guard let text = tfText?.text else { return }
            completionHandler(text)
        }))
        
        ac.addTextField(configurationHandler: { textField in
            textField.placeholder = placeholder
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        present(ac, animated: true)
    }
    
    func alertError(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(ac, animated: true)
    }
}
