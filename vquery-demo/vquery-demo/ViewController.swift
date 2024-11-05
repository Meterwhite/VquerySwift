//
//  ViewController.swift
//  Vquery-demo
//
//  Created by meterwhite on 2024/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    /// Row Stack View
    @IBOutlet weak var rowStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addValueButtonTaped(_ sender: UIButton) {
        
        let randomDemo = Int(arc4random_uniform(4))
        
        // sender -> `Row Value`
        if randomDemo == 0 {
            
            let valueLabel = sender.vquerySiblingByInspector(ofType: UILabel.self,
                                                             accessibilityLabel: "Row Value").first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
        // `Row Stack View` -> `Row` -> `Row Value`
        else if randomDemo == 1 {
            let index = sender.tag
            let valueLabel = rowStackView.arrangedSubviews
                .vqueryByIndex(index: index)
                .vquery(ofType: UILabel.self){ $0.accessibilityLabel == "Row Value" }.first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
        // `Row Stack View` -> `Row` -> `Row Value`
        else if randomDemo == 2 {
            
            let index = sender.tag
            let valueLabel = rowStackView.arrangedSubviews
                .vqueryByInspector(tag: index)
                .vquery(ofType: UILabel.self){ $0.accessibilityLabel == "Row Value" }.first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
        // view -> `Row 0` -> `Row Value`
        else if randomDemo == 3 {
            
            let index = sender.tag
            let valueLabel = view
                .vquery(){ $0.accessibilityLabel == "Row \(String(index))"}
                .vquery(ofType: UILabel.self){ $0.accessibilityLabel == "Row Value" }.first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
    }
    
}

