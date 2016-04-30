//
//  ViewController.swift
//  OnlyShowYourFace
//
//  Created by Serx on 16/4/29.
//  Copyright © 2016年 serxlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    //MARK: - ------All Properties------
    //MARK: -
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var stickyView: UIView!
    

    //MARK: - ------Apple Inc.Func------
    //MARK: -
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init the UI
        inidUIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier: String = "myCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "test and test"
        
        return cell
    }
    
    
    //MARK: - ------Individual Func------
    //MARK: -

    func inidUIView(){
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = true
        self.edgesForExtendedLayout = .None
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let w = self.view.width
        
        self.stickyView.width = w
        self.headerView.width = w
        
        //TODO: the real value should change
        self.tableView.width = w - 40.0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView == tableView {
            
            if scrollView.contentOffset.x == 0 {
                
                let y = scrollView.contentOffset.y
                
                if y > 0 {
                    
                    struct diff {
                        static var previousY: CGFloat = 0.0
                    }
                    guard headerView.bottomY > 0.0 else {
                        return
                    }
                    var bottomY = headerView.bottomY - fabs(y - diff.previousY)
                    
                    bottomY = bottomY > 0.0 ? bottomY : 0.0
                    
                    headerView.bottomY = bottomY
                    stickyView.y = headerView.bottomY
                    
                    self.tableView.y = stickyView.bottomY
                    //TODO: should handle
                    self.tableView.height = self.view.height - stickyView.bottomY - 40
                    
                    diff.previousY = y
                    if diff.previousY >= headerView.height{
                        
                        diff.previousY = 0.0
                    }
                }
                if y < 0 {
                    
                    if headerView.y >= 0{
                        return
                    }
                    
                    var bottomY = headerView.bottomY + fabs(y)
                    bottomY = bottomY <= headerView.height ? bottomY : headerView.height
                    headerView.bottomY = bottomY
                    stickyView.y = headerView.bottomY
                    
                    self.tableView.y = stickyView.bottomY
                }
            }
        }
    }
}

