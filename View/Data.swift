//
//  Data.swift
//  View
//
//  Created by Ananth Bhamidipati on 11/08/16.
//  Copyright © 2016 Ananth Bhamidipati. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire

class Data {

    class var sharedInstance: Data {
    
    struct Static {
        static var instance: Data?
        static var token: dispatch_once_t = 0
            }
    
        dispatch_once(&Static.token) {
            Static.instance = Data()
       }
   
        return Static.instance!
    }
    
    var arrSurvey:[SomeObject] = []
    
    
    func JsonData(onCompletion completion: () -> ()) {
    
    
        SVProgressHUD.show()
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.Native)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        SVProgressHUD.showWithStatus("Loading")
         Alamofire.request(.GET, "https://www-staging.usay.co/app/surveys.json?access_token=6eebeac3dd1dc9c97a06985b6480471211a777b39aa4d0e03747ce6acc4a3369")
        .responseJSON { (response) in
        let jsonresponse = response.result.value as? [[String:AnyObject]]
        if jsonresponse != nil {
        //print(jsonresponse)
        
        self.arrSurvey.removeAll()
    
        for respons in jsonresponse! {
    
        let anobject = SomeObject()
    
        let name = respons["title"] as? String
        if name != nil {
        anobject.naame = name!
        print(name!)
       }
        
       let desc = respons["description"] as? String
       if desc != nil {
       anobject.description = desc!
       print(desc!)
       }
    
       let coveimage = respons["cover_image_url"] as? String
       if coveimage != nil {
       anobject.images = coveimage!
       print(coveimage!)
       }
       
        self.arrSurvey.append(anobject)
        completion()
 
    }
    
    }
        
    }
      
    }


}
