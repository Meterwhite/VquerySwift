//
//  ViewController.swift
//  Vquery-demo
//
//  Created by meterwhite on 2024/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rowStackView: UIStackView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addValueButtonTaped(_ sender: UIButton) {
        
        let randomDemo = Int(arc4random_uniform(4))
        
        // sender -> row.value
        if randomDemo == 3 {
            
            let valueLabel = sender.vquerySiblingByInspector(ofType: UILabel.self,
                                                             accessibilityLabel: "row.valueLabel").first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
        // rowStackView -> row -> row.value
        else if randomDemo == 0 {
            let index = sender.tag
            let valueLabel = rowStackView.arrangedSubviews
                .vqueryByIndex(index: index)
                .vquery(ofType: UILabel.self){ $0.accessibilityLabel == "row.valueLabel" }.first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
        // rowStackView -> row -> row.value
        else if randomDemo == 1 {
            
            let index = sender.tag
            let valueLabel = rowStackView.arrangedSubviews
                .vqueryByInspector(tag: index)
                .vquery(ofType: UILabel.self){ $0.accessibilityLabel == "row.valueLabel" }.first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
        // row -> row.value
        else if randomDemo == 2 {
            
            let index = sender.tag
            let valueLabel = view
                .vquery(){ $0.accessibilityLabel == "row\(String(index))"}
                .vquery(ofType: UILabel.self){ $0.accessibilityLabel == "row.valueLabel" }.first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
        
        else if randomDemo == 4 {
            let valueLabel = sender
                .vquerySuper()
                .vquery(ofType: UILabel.self){ $0.text?.contains("Top") ?? false }.first!
            valueLabel.text = "\(Int(valueLabel.text!)! + 1)"
        }
    }
    
}

