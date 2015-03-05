//
//  ViewController2.swift
//  HotPapper
//
//  Created by Nozomi Teruya on 3/2/15.
//  Copyright (c) 2015 Dpop420. All rights reserved.
//

import UIKit
import MapKit

class ViewController2: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var stationView: UILabel!
    @IBOutlet weak var addressView: UIButton!
    var lat:Double?
    var lon:Double?
    //@IBOutlet weak var urlView: UIButton!
    //@IBOutlet weak var couponView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("in this")
        
        // API先指定
        var keyword = "インドカレー".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        //println(keyword)
        
        var url = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?count=15&large_area=Z011&keyword=" + keyword! + "&is_open_time=now&key=150d3d7de833b99b&format=json"
        
        //println(url)
        
        var reqest = NSURLRequest(URL: NSURL(string: url)!)
        NSURLConnection.sendAsynchronousRequest(reqest,queue:NSOperationQueue.mainQueue(),completionHandler:{
            (res: NSURLResponse!, data: NSData!, error: NSError!) in
            let json = JSON(data: data)
            
            //println(json)
            
            var randInt = Int(arc4random_uniform(UInt32(json["results"]["shop"].count)))//ランダムに店を決定
            
            if let name = json["results"]["shop"][randInt]["name"].string{//店名
                println("name:" + name)
                self.nameView.text = "店名：" + name
                self.nameView.numberOfLines = 2
            }
            if let image = json["results"]["shop"][randInt]["photo"]["mobile"]["l"].string{//料理画像
                println(image)
                
                let imageUrl : NSURL = NSURL(string: image)!
                
                let imageDate = NSData(contentsOfURL: imageUrl)
                let image = UIImage(data: imageDate!)
                self.imageView!.image = image
            }
            if let station_name = json["results"]["shop"][randInt]["station_name"].string{//最寄り駅名
                println("station_name:" + station_name)
                self.stationView.text = "最寄り駅：" + station_name
            }
            if let adress = json["results"]["shop"][randInt]["address"].string{//住所
                println("address:" + adress)
                self.addressView.setTitle(
                    "住所：" + adress, forState: UIControlState.Normal)
                self.lat = json["results"]["shop"][randInt]["lat"].double
                println(self.lat)
                self.lon = json["results"]["shop"][randInt]["lng"].double
                println(self.lon)
                
                
                
            }
            /*if let urls = json["results"]["shop"][randInt]["urls"].string{//店舗url
                println("urls:" + urls)
                self.urlView.setTitle(
                    "店舗URL：" + url, forState: UIControlState.Normal)
                
            }
            if let coupon_urls = json["results"]["shop"][randInt]["coupon_urls"].string{//クーポンURL
                println("coupon_urls:" + coupon_urls)
                self.couponView.setTitle(
                    "クーポンURL：" + coupon_urls, forState: UIControlState.Normal)
            }*/
            
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLet(hoge:Int) -> Double{
        return lat!
    }
    
    func getLon(hoge:Int) -> Double{
        return lon!
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
