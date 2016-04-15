//
//  UIViewControllerTests.swift
//  TDCore
//
//  Created by Josh Campion on 15/04/2016.
//  Copyright © 2016 The Distance. All rights reserved.
//

import XCTest
import TheDistanceCore

class ViewControllerTests: XCTestCase {
    
    
    let vc = UIViewController()
    let vcCollection = UICollectionViewController()
    let vcTable = UITableViewController()
    
    let navVC = UINavigationController()
    
    let splitVC = UISplitViewController()
    let splitNavVC = UINavigationController()
    
    let splitCollapsedVC = UISplitViewController()
    let splitCollapsedNavVC = UINavigationController()
    let splitCollapsedTableVC = UITableViewController()
    
    override func setUp() {
        super.setUp()
        
        navVC.viewControllers = [vcCollection, vc]
        splitNavVC.viewControllers = [vcTable]
        splitVC.viewControllers = [splitNavVC, navVC]
        
        splitCollapsedNavVC.viewControllers = [splitCollapsedTableVC]
        splitCollapsedVC.viewControllers = [splitCollapsedNavVC]
    }
    
    func testNavigationRootForVC() {
        
        XCTAssertEqual(vc.navigationRootViewController(), vc)
        XCTAssertEqual(vcTable.navigationRootViewController(), vcTable)
        XCTAssertEqual(vcCollection.navigationRootViewController(), vcCollection)
    }
    
    func testNavigationRootForNavigationVC() {
        
        XCTAssertEqual(navVC.navigationRootViewController(), vcCollection)
        XCTAssertEqual(splitNavVC.navigationRootViewController(), vcTable)
    }
    
    func testNavigationRootForSplitVC() {
        
        XCTAssertEqual(splitVC.navigationRootViewController(), vcTable)
        XCTAssertEqual(splitCollapsedVC.navigationRootViewController(), splitCollapsedTableVC)
    }
    
    func testNavigationTopForVC() {
        
        XCTAssertEqual(vc.navigationTopViewController(), vc)
        XCTAssertEqual(vcTable.navigationTopViewController(), vcTable)
        XCTAssertEqual(vcCollection.navigationTopViewController(), vcCollection)
    }
    
    func testNavigationTopNavigationVC() {
            XCTAssertEqual(navVC.navigationTopViewController(), vc)
        XCTAssertEqual(splitNavVC.navigationTopViewController(), vcTable)
    }
    
    func testNavigationTopSplitVC() {
        XCTAssertEqual(splitVC.navigationTopViewController(), vc)
        XCTAssertEqual(splitCollapsedVC.navigationTopViewController(), splitCollapsedTableVC)
    }
}

