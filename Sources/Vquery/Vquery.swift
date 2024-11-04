//
//  Vquery.swift
//  Version 1.0.0
//
//  Created by meterwhite on 2024/10/15.
//


import Foundation
import UIKit

/*
 Vquery provides a querying service for views under UIKit in Swift. Its design goal is to reduce repetitive code in scenarios with numerous controls.
 
 1. Vquery methods are similar to map methods:
    view.vquery { $0.tag == 2024 }
    view.vquery(ofType: UILabel.self) { $0.text == "2024" }
 
 2. Vquery can be mixed with Swift higher-order functions like map:
    view.vquery { $0.tag == 2024 }.map { $0 is UILabel }
 
 3. Vquery enhances support for xib (Interface Builder) queries:
    stackView.vqueryByInspector(ofType: UIImageView.self, tag: row, accessibilityLabel: "row.avatar")
    The above shows a method to find the avatar in the row within a UIStackView.
 
 4. Vquery supports chained calls and extends Array.
    view.vquery { .. }.vquery { .. }
 
 Principles behind Vquery:
    Vquery extends UIView and Array<UIView> with extension methods, making them compatible with higher-order functions like map.
    Extension methods in UIView ultimately call extension methods in Array<UIView>. The methods in Array<UIView> handle queries and return the appropriate collection types.
 
 Design of Vquery parameters:
    Each parameter in Vquery methods is designed to represent a dimension of information for locating a view.
 
 */

public extension UIView {
    
    /// Queries the current view and its subviews by matching type `ofType` and condition `condition`.
    /// - Parameters:
    ///   - ofType: Type to match.
    ///   - through: Determines search behavior; if true, continues searching subviews after a match. Default is false.
    ///   - condition: Condition to match; if nil, all subviews are queried, and any value of through is irrelevant.
    /// - Returns: Query results
    func vquery<T: UIView> (
        ofType: T.Type = UIView.self,
        through: Bool = false,
        condition: ((T) -> Bool)? = nil
    ) -> [T] {
        
        return [self].vquery(ofType: ofType, through: through, condition: condition)
    }
    
    /// Queries the views in the collection and their subviews by matching type `ofType` and condition `condition`.
    ///
    /// This method is customized for xib queries, associating properties with the query panel's `Attributes inspector` (`tag`) and the panel's `Identity Inspector` (`restorationIdentifier`, `accessibilityLabel`, `accessibilityHint`).
    /// Note that `restorationIdentifier` is unique in the xib editor.
    ///
    /// Generally, restorationIdentifier can be a unique identifier for the view.
    /// accessibilityLabel and accessibilityIdentifier can be repeated and used as identifiers for a class of views.
    /// Example:
    /// stackView.vqueryByInspector(ofType: UILabel.self)
    ///
    /// - Parameters:
    ///   - ofType: Type to match.
    ///   - tag: This property supports visual editing in the `Attributes Inspector` panel.
    ///   - restorationIdentifier: This property supports visual editing in the `Identity Inspector` panel.
    ///   - accessibilityIdentifier: This property supports visual editing in the `Identity Inspector` panel.
    ///   - accessibilityLabel: This property supports visual editing in the `Identity Inspector` panel.
    ///   - accessibilityHint: This property supports visual editing in the `Identity Inspector` panel.
    ///   - through: Determines search behavior; if true, continues searching subviews after a match. Default is false.
    ///   - condition: Condition to match; if nil, all subviews are queried, and any value of through is irrelevant.
    /// - Returns: Query results
    func vqueryByInspector<T: UIView> (
        ofType: T.Type = UIView.self,
        tag: Int? = nil,
        restorationIdentifier: String? = nil,
        accessibilityIdentifier: String? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil,
        through: Bool = false,
        condition: ((T) -> Bool)? = nil
    ) -> [T]  {
        
        return [self].vqueryByInspector(ofType: ofType,
                                        tag: tag,
                                        restorationIdentifier: restorationIdentifier,
                                        accessibilityIdentifier: accessibilityIdentifier,
                                        accessibilityLabel: accessibilityLabel,
                                        accessibilityHint: accessibilityHint,
                                        through: through,
                                        condition: condition)
    }
    
    /// Queries an item in the current view and its subviews by matching index. Non-recursive. Returns an empty collection if the index is invalid.
    func vqueryByIndex<T: UIView>(
        ofType: T.Type = UIView.self,
        index: Int
    ) -> [T] {
        
        return [self].vqueryByIndex(ofType: ofType, index: index)
    }
    
    /// Queries the matching superviews in the collection.
    func vquerySuper<T: UIView> (
        ofType: T.Type = UIView.self,
        condition: ((T) -> Bool)? = nil
    ) -> [T] {
        
        return [self].vquerySuper(ofType: ofType, condition: condition)
    }
    
    /// Similar to vqueryByInspector, this method is used to query sibling views.
    func vquerySiblingByInspector<T: UIView>(
        ofType: T.Type = UIView.self,
        tag: Int? = nil,
        restorationIdentifier: String? = nil,
        accessibilityIdentifier: String? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil,
        condition: ((T) -> Bool)? = nil
    ) -> [T]  {
        
        return [self].vquerySiblingByInspector(ofType: ofType,
                                               tag: tag,
                                               restorationIdentifier: restorationIdentifier,
                                               accessibilityIdentifier: accessibilityIdentifier,
                                               accessibilityLabel: accessibilityLabel,
                                               accessibilityHint: accessibilityHint,
                                               condition: condition)
    }
    
    /// Queries sibling views at the same hierarchy level in the current view and its subviews.
    func vquerySibling<T: UIView>(
        ofType: T.Type = UIView.self,
        condition: ((T) -> Bool)? = nil
    ) -> [T] {
        
        return [self].vquerySibling(ofType: ofType, condition: condition)
    }
    
    func vqueryIndex() -> Int? {
        
        return superview?.subviews.firstIndex(of: self)
    }
}

public extension Array where Element: UIView {
    
    /// Queries the views in the collection and their subviews by matching type `ofType` and condition `condition`.
    /// - Parameters:
    ///   - ofType: Type to match.
    ///   - through: Determines search behavior; if true, continues searching subviews after a match. Default is false.
    ///   - condition: Condition to match; if nil, all subviews are queried, and any value of through is irrelevant.
    /// - Returns: Query results
    func vquery<T: UIView>(
        ofType: T.Type = UIView.self,
        through: Bool = false,
        condition: ((T) -> Bool)? = nil
    ) -> [T] {
        var result: [T] = []
        var stack: [UIView] = self
        while !stack.isEmpty {
            let view = stack.removeLast()
            if let match = view as? T, condition?(match) ?? true {
                result.append(match)
                if !through {
                    continue
                }
            }
            stack.append(contentsOf: view.subviews)
        }
        return result
    }
    
    /// Queries the views in the collection and their subviews by matching type `ofType` and condition `condition`.
    ///
    /// This method is customized for xib queries, associating properties with the query panel's `Attributes inspector` (`tag`) and the panel's `Identity Inspector` (`restorationIdentifier`, `accessibilityLabel`, `accessibilityHint`).
    /// Note that `restorationIdentifier` is unique in the xib editor.
    /// - Parameters:
    ///   - ofType: Type to match.
    ///   - tag: This property supports visual editing in the `Attributes Inspector` panel.
    ///   - restorationIdentifier: This property supports visual editing in the `Identity Inspector` panel.
    ///   - accessibilityIdentifier: This property supports visual editing in the `Identity Inspector` panel.
    ///   - accessibilityLabel: This property supports visual editing in the `Identity Inspector` panel.
    ///   - accessibilityHint: This property supports visual editing in the `Identity Inspector` panel.
    ///   - through: Determines search behavior; if true, continues searching subviews after a match. Default is false.
    ///   - condition: Condition to match; if nil, all subviews are queried, and any value of through is irrelevant.
    /// - Returns: Query results
    func vqueryByInspector<T: UIView>(
        ofType: T.Type = UIView.self,
        tag: Int? = nil,
        restorationIdentifier: String? = nil,
        accessibilityIdentifier: String? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil,
        through: Bool = false,
        condition: ((T) -> Bool)? = nil
    ) -> [T] {
        
        return vquery(ofType: ofType, through: through) { view in
            guard (tag == nil || view.tag == tag),
                  (restorationIdentifier == nil || view.restorationIdentifier == restorationIdentifier),
                  (accessibilityIdentifier == nil || view.accessibilityIdentifier == accessibilityIdentifier),
                  (accessibilityLabel == nil || view.accessibilityLabel == accessibilityLabel),
                  (accessibilityHint == nil || view.accessibilityHint == accessibilityHint),
                  condition?(view) ?? true else {
                return false
            }
            return true
        }
    }
    
    /// Queries an item in the subviews of views in the collection by matching index. Non-recursive. Returns an empty collection if the index is invalid.
    func vqueryByIndex<T: UIView>(
        ofType: T.Type = UIView.self,
        index: Int
    ) -> [T] {
        
        let views: [UIView] = self
        if views.indices.contains(index), let view = views[index] as? T {
            return [view]
        }
        return []
    }
    
    /// Queries the matching superviews in the collection.
    func vquerySuper<T: UIView>(
        ofType: T.Type = UIView.self,
        condition: ((T) -> Bool)? = nil
    ) -> [T] {
        
        var result: [T] = []
        var iterator = self.makeIterator()
        while let view = iterator.next() {
            var currentSuperview = view.superview
            while let superview = currentSuperview as? T {
                if condition?(superview) ?? true {
                    result.append(superview)
                    break
                }
                currentSuperview = superview.superview
            }
        }
        return result
    }
    
    /// Queries sibling views at the same hierarchy level in the current view and its subviews.
    func vquerySibling<T: UIView>(
        ofType: T.Type = UIView.self,
        condition: ((T) -> Bool)? = nil
    ) -> [T] {
        
        var result: [T] = []
        for view in self {
            guard let superview = view.superview else { continue }
            for sibling in superview.subviews where sibling !== view {
                if let match = sibling as? T, condition?(match) ?? true {
                    result.append(match)
                }
            }
        }
        return result
    }
    
    /// Similar to vqueryByInspector, this method is used to query sibling views.
    func vquerySiblingByInspector<T: UIView>(
        ofType: T.Type = UIView.self as! T.Type,
        tag: Int? = nil,
        restorationIdentifier: String? = nil,
        accessibilityIdentifier: String? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil,
        condition: ((T) -> Bool)? = nil
    ) -> [T] {
        
        var result: [T] = []
        for view in self {
            guard let superview = view.superview else { continue }
            for sibling in superview.subviews where sibling !== view {
                guard (tag == nil || sibling.tag == tag),
                      (sibling.restorationIdentifier == restorationIdentifier),
                      (accessibilityIdentifier == nil || sibling.accessibilityIdentifier == accessibilityIdentifier),
                      (accessibilityLabel == nil || sibling.accessibilityLabel == accessibilityLabel),
                      (accessibilityHint == nil || sibling.accessibilityHint == accessibilityHint),
                      condition?(sibling as! T) ?? true else {
                    continue
                }
                if let match = sibling as? T {
                    result.append(match)
                }
            }
        }
        return result
    }
    
    /// Queries the indices of the views in the collection within their parent views.
    func vqueryIndex() -> [Int] {
        
        var result: [Int] = []
        for view in self {
            if let index = view.superview?.subviews.firstIndex(of: view) {
                result.append(index)
            }
        }
        return result
    }
    
}
