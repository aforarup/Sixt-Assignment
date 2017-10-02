//
//  Home.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import UIKit

protocol HomeViewInput {
    func showLoader()
    func prepareForViewing()
    
}

protocol HomeViewOutput {
    func setUpView()
    func connectViews()
}

class HomeViewController: UIViewController {
    var presenter: HomeViewOutput?
    
    @IBOutlet weak var mapViewPlaceHolder: UIView!
    @IBOutlet weak var listViewPlaceHolder: UIView!
}

extension HomeViewController {
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.setUpView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController {
    // MARK:- Behaviours
    func attach(viewController vc: UIViewController, for type: DisplayRouterType) {
        switch type {
        case .map:
            self.addChildViewController(vc)
            self.addSubview(subView: vc.view, toView: self.mapViewPlaceHolder)
            
        case .list:
            self.addChildViewController(vc)
            self.addSubview(subView: vc.view, toView: self.listViewPlaceHolder)
            
        }
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        subView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(getParentViewConstraints(for: "subView", with: viewBindingsDict))
    }
    
    func getParentViewConstraints(for subviewMarker: String, with viewBindingsDict:[String: AnyObject]) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(subviewMarker)]|",
                                       options: [], metrics: nil, views: viewBindingsDict),
                NSLayoutConstraint.constraints(withVisualFormat: "V:|[\(subviewMarker)]|",
                                               options: [], metrics: nil, views: viewBindingsDict)
            ].flatMap{ $0 }
    }
}

extension HomeViewController: HomeViewInput {
    func showLoader() {
        
    }
    
    func prepareForViewing() {
        self.presenter?.connectViews()
    }
}
