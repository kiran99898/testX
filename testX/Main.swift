//
//  ViewController.swift
//  testX
//
//  Created by kiran on 12/24/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import Alamofire

class Main: UIViewController {
    
    var newSqlManager =  SqlManager()
    
   // var dataXArray = [ModalX]()
    //let url 
    override func viewDidLoad() {
        super.viewDidLoad()
        newSqlManager.createDatabase()
        self.newSqlManager.deleteMyData()
        getData(fromUrl: url)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    
    func getData(fromUrl: String) {
        
        Alamofire.request(fromUrl).responseJSON { response in
            switch response.result {
            case .success:
                let productData = response.result.value as! NSArray
            for product in productData {
                    let Json = product as! NSDictionary
                
                        let id = Json["id"]  as! Int
                        let name = Json["name"] as! String
                        let parent = Json["parent"] as! Int
                        let description = Json["description"] as! String
                    self.newSqlManager.putEventData(id: id , name: name , parent: parent , description: description )
                                      }
            case .failure(let error):
                print(error)
            }
        }
       
}
    
    @IBAction func showData(_ sender: Any) {
        print("button pressed ")
    }
    
}

