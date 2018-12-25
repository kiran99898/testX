
//
//  Created by kiran on 10/9/18.
//  Copyright © 2018 kiran. All rights reserved.
//
import Foundation
import SQLite3


class SqlManager {
    var  db: OpaquePointer?
    //MARK: - CREATE DATABASE
    func createDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("DataX.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return
        }
        
        if sqlite3_exec(db, "CREATE TABLE  IF NOT EXISTS myData (Id INTEGER PRIMARY KEY AUTOINCREMENT, idd Int ,name String, parent Int, description String )", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }else{
            print("success creating dataX table")
        }
        
        
    }
    
    func putEventData(id: Int, name: String, parent: Int, description: String) {
        createDatabase()
        let updateStatementString = "INSERT INTO myData ( idd, name, parent, description) VALUES (\"\(id)\",\"\(name)\",\"\(parent)\",\"\(description)\");"
        print(updateStatementString)
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully insert event data.")
            } else {
                print("Could not insert event data.")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            print("UPDATE statement could not be prepared")
        }
    }
    
    func getProduct() -> [ModalX]{
        createDatabase()
        var dataFromLocale = [ModalX]()
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM myData where parent == 0 ;"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return dataFromLocale
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let productData:NSDictionary = [
                "id" : String(cString: sqlite3_column_text(stmt, 0)),
                "name" : String(cString: sqlite3_column_text(stmt, 1)),
                "parent" : String(cString: sqlite3_column_text(stmt, 3)),
                "description" : String(cString: sqlite3_column_text(stmt, 4)),
                
                
                ]
            dataFromLocale.append(ModalX(productJson: productData))
            //  dataFromLocale.append(ModalX(user: productData))
        }
        return dataFromLocale
    }
    
    func deleteMyData() {
        createDatabase()
        var stmt:OpaquePointer?
        let queryString = "DELETE FROM myData;"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
        }
        
    }



}



 
 /*
    
    //login
    
    func userLogin(email: String, password: String) -> Bool{
        createDatabase()
        var isUserVaild = false
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Users WHERE Email = '\(email)' and Password = '\(password)';"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            if email == String(cString: sqlite3_column_text(stmt, 4)) &&
                password ==  String(cString: sqlite3_column_text(stmt, 5)) {
                isUserVaild = true
                let userIdtoStore  = String(cString: sqlite3_column_text(stmt, 0))
                let usernameToStore  = String(cString: sqlite3_column_text(stmt, 3))
                UserDefaults.standard.set(userIdtoStore, forKey: "userId")
                UserDefaults.standard.set(usernameToStore, forKey: "userName")
            }
            else {
                isUserVaild = false
            }
            
        }
        return isUserVaild
    }
    
    //check email if it is already there
    
    func checkIfEmailisAlreadyThere(email: String) ->Bool {
        createDatabase()
        var isEmailAlreadyThere = false
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Users WHERE Email = '\(email)';"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return isEmailAlreadyThere
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            if  email == String(cString: sqlite3_column_text(stmt, 4)) {
                isEmailAlreadyThere = true
            } else {
                isEmailAlreadyThere = false
            }
            
        }
        return isEmailAlreadyThere
    }
    
    
    
    //MARK: - FOR EVENTS DATA
    
    func putEventData(title: String, description: String, userId: String, location: String, date: String, userName: String) {
        createDatabase()
        let updateStatementString = "INSERT INTO Events ( EventTitle, EventDescription, EventLocation, Date, UserId, userName) VALUES (\"\(title)\",\"\(description)\",\"\(location)\",\"\(date)\",\"\(userId)\",\"\(userName)\");"
        print(updateStatementString)
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully insert event data.")
            } else {
                print("Could not insert event data.")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            print("UPDATE statement could not be prepared")
        }
    }
    
    
    func getEventData() -> [EventModel]{
        createDatabase()
        var eventData = [EventModel]()
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Events ;"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return eventData
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let eventDict:NSDictionary = [
                "eventId" : String(cString: sqlite3_column_text(stmt, 0)),
                "eventTitle" : String(cString: sqlite3_column_text(stmt, 1)),
                "eventDescription" : String(cString: sqlite3_column_text(stmt, 2)),
                "eventLocation" : String(cString: sqlite3_column_text(stmt, 3)),
                "userId" : String(cString: sqlite3_column_text(stmt, 4)),
                "userName" : String(cString: sqlite3_column_text(stmt, 6))
            ]
            eventData.append(EventModel(event: eventDict ))
        }
        return eventData
    }
    
    func getEventDataFromSpecificUser(userId: String)-> [EventModel] {
        createDatabase()
        var userCreatedEvent = [EventModel]()
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Events WHERE UserId = '\(userId)';"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return userCreatedEvent
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let userCreatedDict:NSDictionary = [
                "eventId" : String(cString: sqlite3_column_text(stmt, 0)),
                "eventTitle" : String(cString: sqlite3_column_text(stmt, 1)),
                "eventDescription" : String(cString: sqlite3_column_text(stmt, 2)),
                "eventLocation" : String(cString: sqlite3_column_text(stmt, 3)),
                "userId" : String(cString: sqlite3_column_text(stmt, 4)),
                "userName" : String(cString: sqlite3_column_text(stmt, 5))
                
            ]
            userCreatedEvent.append(EventModel(event: userCreatedDict ))
        }
        return userCreatedEvent
    }
    
    
}


*/
