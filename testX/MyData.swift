//
//  MyData.swift
//  testX
//
//  Created by kiran on 12/24/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit

class MyData: UIViewController {
   // var productDataArray = [ModalX]()

    @IBOutlet weak var testXtableView: UITableView!
    let newSqlManager = SqlManager()

    
    var productDataArray = [ModalX]() {
        didSet {
            testXtableView.reloadData()
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        testXtableView.delegate = self
        testXtableView.dataSource = self
        newSqlManager.createDatabase()
        productDataArray = newSqlManager.getProduct()
        print(newSqlManager.getProduct())
        
    
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//         productDataArray = newSqlManager.getProduct()
//
//    }
}

extension MyData: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = testXtableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = productDataArray[indexPath.row].name
        
       // cell.detailTextLabel?.text = productDataArray[indexPath.row].name
        print(productDataArray[indexPath.row].name!)
        return cell
    }
    
    
}

