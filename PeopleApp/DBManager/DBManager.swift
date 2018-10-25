import Foundation
import Alamofire

class DBManager{
    func requestAPIToGet(url:String,parameters:[String:String]?,headers:[String:String]?,completion:@escaping (AnyObject)->Void){
        let decoder = JSONDecoder()
        var array = [HiringJobPostDataModel]()
        Alamofire.request(url, method: HTTPMethod.get
            , parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseJSON) in
                guard let jsonData = responseJSON.result.value as? [String:Any] else { return }
                guard let postJsonData = jsonData["data"] as? [[String:Any]] else { return }
                if postJsonData.count == 0{
                    
                }else{
                    for i in 0...postJsonData.count-1{
                        var jsonObject = postJsonData[i]
                        jsonObject["prev"] = jsonData["prev"]
                        jsonObject["next"] = jsonData["next"]
                        jsonObject["totalJobCount"] = jsonData["totalJobCount"]
                        do{
                            let postData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted)
                            let postModel = try decoder.decode(HiringJobPostDataModel.self, from: postData)
                            array.append(postModel)
                        }catch{
                            
                        }
                    }
                    completion(array as AnyObject)
                }
        }
    }
}
