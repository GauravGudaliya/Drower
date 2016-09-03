//
//  AppDelegate.swift
//  Drower
//
//  Created by Gaurav on 8/12/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITableViewDelegate,UITableViewDataSource {

    var window: UIWindow!
    var viewDrower:UIView = UIView()
    var tableDrower: UITableView  =   UITableView()
    var scrolView:UIScrollView = UIScrollView()
    var arrDrower:NSMutableArray=NSMutableArray()
    var arrDrowerImg:NSMutableArray=NSMutableArray()
    var imgProfile:UIImageView=UIImageView()
    var lblUsername:UILabel=UILabel()
    var rootViewController:UINavigationController=UINavigationController()
    var mainStoryboard: UIStoryboard = UIStoryboard()
    
    class func sharedInstance() -> (AppDelegate)
    {
        let sharedinstance = UIApplication.sharedApplication().delegate as! AppDelegate
        return sharedinstance
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        arrDrower=["Home","FillCart From Previous Orders","Hot Offers","Take Picture of Handwritten List","My Address","My Orders","My Wallet","Notification Center","Refer a Friend","Feedback","Rate Us","Terms And Condition","About Us","FAQ","Contact Us","Logout"]
        arrDrowerImg=["icon_home","icon_copycart","icon_offers","icon_orderpic","icon_location","icon_orders","wallet","icon_notification","icon_referral","icon_feedback","icon_rateus","icon_privacy","icon_aboutus","icon_faq","icon_contactus","icon_logout"]
        rootViewController = self.window!.rootViewController as! UINavigationController
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        setup()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func setup()
    {
        NSUserDefaults.standardUserDefaults().setObject(window.frame.height / 8.12, forKey: "NavigationSize")
        
        viewDrower.frame = CGRectMake(0,0, window.frame.width ,window.frame.height);
        viewDrower.backgroundColor = UIColor(red:0.2, green: 0.2, blue: 0.2, alpha: 0.3)
        
        scrolView=UIScrollView(frame: CGRectMake(0,0,window.frame.width - ( window.frame.width/3.5),viewDrower.frame.height))
        scrolView.bounces = false
        scrolView.showsVerticalScrollIndicator=false
        scrolView.backgroundColor = UIColor(red:0.2, green: 0.2, blue: 0.2, alpha: 0.7)
        
        let vi:UIView = UIView(frame: CGRectMake(0,0, window.frame.width - ( window.frame.width/3.5),window.frame.height / 6 + 14))
        vi.backgroundColor=UIColor(red:0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        
        imgProfile=UIImageView(frame: CGRectMake(10, 14, vi.frame.height-14, vi.frame.height-14))
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.clipsToBounds=true
        imgProfile.image=UIImage(named: "icon_profile")
        imgProfile.backgroundColor=UIColor.lightGrayColor()
        vi.addSubview(imgProfile)
    
        
        lblUsername.frame = CGRectMake(imgProfile.frame.size.width+20,0,vi.frame.width-imgProfile.frame.size.width+20,vi.frame.height)
        lblUsername.numberOfLines=0
        lblUsername.textColor=UIColor.whiteColor()
        lblUsername.text="User name"
        vi.addSubview(lblUsername)
        scrolView.addSubview(vi)
        
        tableDrower.frame  =   CGRectMake(0,vi.frame.height, window.frame.width - ( window.frame.width/3.5) ,(window.frame.height / 10) * CGFloat( arrDrower.count));
        scrolView.contentSize=CGSizeMake(scrolView.frame.width,tableDrower.frame.origin.y + tableDrower.frame.height)
        tableDrower.bounces=false
        
        
        tableDrower.separatorStyle = UITableViewCellSeparatorStyle.None
        tableDrower.showsVerticalScrollIndicator=false
        tableDrower.showsHorizontalScrollIndicator=false
        tableDrower.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableDrower.backgroundColor = UIColor.clearColor()
        self.tableDrower.delegate      =   self
        self.tableDrower.dataSource    =   self
        scrolView.addSubview(tableDrower)
        viewDrower.addSubview(scrolView)
        
        dispatch_async(dispatch_get_main_queue(),
                       {
                        self.window!.addSubview(self.viewDrower)
                        self.viewDrower.hidden=true
                        })
    }
    func  OpenOrCloseDrower()
    {
        if(NSUserDefaults.standardUserDefaults().objectForKey("isFirst") as? String == "1")
        {
            arrDrower.removeLastObject()
            arrDrowerImg.removeLastObject()
            arrDrowerImg.addObject("icon_logout")
            arrDrower.addObject("Logout")
            lblUsername.text = NSUserDefaults.standardUserDefaults().objectForKey("username")as? String
        }
        else
        {
            arrDrower.removeLastObject()
            arrDrower.addObject("Login")
            arrDrowerImg.removeLastObject()
            arrDrowerImg.addObject("icon_login")
        }
        tableDrower.reloadData()
        if(self.viewDrower.hidden)
        {
            presentDrower()
        }
        else
        {
            dismissDrower()
        }
    }
    func presentDrower()
    {
        self.viewDrower.hidden=false
        scrolView.transform = CGAffineTransformTranslate(window.transform, -self.scrolView.frame.size.width, 0)
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scrolView.transform = CGAffineTransformIdentity
        }
    }
    func dismissDrower()
    {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.scrolView.transform=CGAffineTransformTranslate(self.window.transform,-self.scrolView.frame.size.height,0)
        }) { (value: Bool) -> Void in
            self.viewDrower.hidden=true
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
 
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor(red:0.2, green: 0.2, blue: 0.2, alpha: 0.7)
            if(cell.viewWithTag(102) != nil)
            {
                let image :UIImageView = cell.viewWithTag(102) as! UIImageView
                image.removeFromSuperview()
            }
            if(cell.viewWithTag(103) != nil)
            {
                let lbl1 :UILabel = cell.viewWithTag(103) as! UILabel
                lbl1.removeFromSuperview()
            }
            let img:UIImageView=UIImageView(frame: CGRectMake(10,cell.frame.height/4, cell.frame.height/2, cell.frame.height/2))
            //img.backgroundColor=UIColor.lightGrayColor()
            img.tag=102
            img.image = UIImage(named: arrDrowerImg.objectAtIndex(indexPath.row)as! String)
            cell.addSubview(img)
            let lbl:UILabel=UILabel(frame: CGRectMake(img.frame.width+20,0, cell.frame.width/1.5, cell.frame.height))
            lbl.text = arrDrower.objectAtIndex(indexPath.row) as? String
            lbl.tag=103
            lbl.textColor = UIColor.whiteColor()
            lbl.font=UIFont(name: "Helvetica Neue", size:16)
            lbl.numberOfLines=0
            cell.addSubview(lbl)

            return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrDrower.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if(indexPath.row==0)
            {
                let vc = mainStoryboard.instantiateViewControllerWithIdentifier("MapView") as! MapView
                rootViewController.pushViewController(vc, animated:true)
            }
            else if(indexPath.row==1)
            {

            }
            else if(indexPath.row==2)
            {
 
            }
            else if(indexPath.row==3)
            {
 
            }
            else if(indexPath.row==4)
            {

            }
            else if(indexPath.row==5)
            {

            }
            else if(indexPath.row==6)
            {

            }
            else if(indexPath.row==7)
            {

            }
            else if(indexPath.row==8)
            {

            }
            else if(indexPath.row==9)
            {

            }
            else if(indexPath.row==10)
            {

            }
            else if(indexPath.row==11)
            {
                
            }
            else if(indexPath.row==12)
            {
               
            }
            else if(indexPath.row==13)
            {
                
            }
            else if(indexPath.row==14)
            {
              
            }
            else if(indexPath.row==15)
            {
                
            }
            dismissDrower()
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        dismissDrower()
    }
    
    
}

