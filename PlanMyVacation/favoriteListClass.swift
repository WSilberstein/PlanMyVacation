//
//  favoriteListClass.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/28/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started
//CLASS NOT USED
import Foundation

//

//
// Source of Movie Data: TMD. Link to API: https://developers.themoviedb.org/3/getting-started/json-and-jsonp

class favoriteListClass{
    
    let propListPath = Bundle.main.path(forResource: "favData", ofType: "plist")
   
    let proplistURL : URL = Bundle.main.url(forResource: "favData", withExtension:"plist")!
    //above lines cited from online: www.stackoverflow.com/questions/47419327/swift-4-adding-dictionaries-to-plist
    
    func deletePlace(atIndex: Int){
        do {
            var plistDict = try loadPropertyList()
            plistDict["favoriteList"]?.remove(at: atIndex)
            try savePropertyList(plistDict)
        } catch {print(error)}
    }
    
    func insertPlace(placeName: String){
        //print("reached insert method")
        do{
            _ = try loadPropertyList()
        }
        catch{
        print(error)
        }
        
        do{
        var plistDict = try loadPropertyList()
        for placetitle in plistDict["favoriteList"]!{
            if placetitle == placeName {
                return
            }
            else{}
        }
        plistDict["favoriteList"]?.append(placeName)
        try savePropertyList(plistDict)
        }
        catch{
            print(error)
        }
    }
  
    func savePropertyList(_ plist: Any) throws
    {
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: proplistURL)
    }
    //above block code cited from online: https://stackoverflow.com/questions/47419327/swift-4-adding-dictionaries-to-plist

    func loadPropertyList() throws -> [String:[String]]
    {
        let propListDict: AnyObject = NSDictionary(contentsOfFile: propListPath!)!
        //print("loadproplist dict: \(propListDict)")
        let proplist = ["favoriteList" : propListDict.object(forKey: "favoriteList") as! Array<String>]
        //print("loadproplist list: \(proplist)")
        return proplist
    }
    //above block code cited from online: www.stackoverflow.com/questions/47419327/swift-4-adding-dictionaries-to-plist
}

