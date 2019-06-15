import UIKit
import PlaygroundSupport

//
//struct Github : Codable{
//    var actor: Actor
//
//}
//struct Actor: Codable {
//    var id: Int
//    var login:String
//    var description:String?
//    var displaylogin:String?
//
//    private enum Codingkeys: String, CodingKey {
//        case id
//        case login
//        case description
//        case displaylogin = "display_login"
//    }
//}
//
//    func makeRequestJson(){
//        var actor = [Actor]()
//        var urlString = "https://api.github.com/repos/ReactiveX/RxSwift/events"
//    guard let url = URL(string: urlString) else {return}
//    URLSession.shared.dataTask(with: url) { (data, reponse, error) in
//        guard error == nil else {print(error?.localizedDescription)
//            return}
//        guard (reponse as! HTTPURLResponse).statusCode == 200 else {return}
//        guard let data = data else {return}
//        do {
//            var user = try JSONDecoder().decode([Github].self, from: data)
//           actor = []
//            DispatchQueue.main.async {
//                user.map{actor.append($0.actor)}
//                user.forEach{print("\($0.actor.id)")}
//            }
////            for item in user {
////               actor.append(item.actor)
////            }
////           actor.forEach{print("\($0.login)")}
//        }catch let error {
//            print(error.localizedDescription)
//        }
//
//    }.resume()
//}
//makeRequestJson()
//
//

//struct Github : Codable{
//    var actor: Actor
//    struct Actor: Codable {
//        var id: Int
//        var login:String
//        var description:String?
//        var displaylogin:String?
//
//        private enum Codingkeys: String, CodingKey {
//            case id
//            case login
//            case description
//            case displaylogin = "display_login"
//        }
//    }
//}
//
// let url = URL(string: "https://api.github.com/repos/ReactiveX/RxSwift/events")
//
//var github = [Github.Actor]()
//URLSession.shared.dataTask(with: url!) { (data, response, error) in
//         guard error == nil else {return}
//    guard (response as! HTTPURLResponse).statusCode == 200 else {return}
//        guard let data = data else {return}
//        do {
//            var user = try JSONDecoder().decode([Github].self, from: data)
//            github = []
//            for item in user {
//                github.append(item.actor)
//            }
//            github.forEach{print("\($0.id)")}
//        }catch let error {
//            print(error.localizedDescription)
//        }
//
//    }.resume()

//struct Hose: Codable {
//    var data: [Promotion]
//
//}
//
//struct Promotion: Codable {
//    var id: Int
//    var keystring: String
//    var availableusage: Int
//    private enum Codingkeys: String, CodingKey {
//        case id
//        case keystring = "key_string"
//        case availableusage = "available_usage"
//    }
//}
//
//let url = URL(string: "http://159.65.135.188:9670/promo/list")
//var promotions = [Promotion]()
//URLSession.shared.dataTask(with: url!) { (data, response, error) in
//    guard error == nil else {return}
//    guard (response as! HTTPURLResponse).statusCode == 200 else {return}
//    guard let data = data else {return}
//    do {
//        var hoses = try JSONDecoder().decode(Hose.self, from: data)
//        promotions = hoses.data
//        promotions.forEach{print("\($0.id)")}
//    }catch {
//        print(error.localizedDescription)
//    }
//
//}.resume()

//PlaygroundPage.current.needsIndefiniteExecution = true
//
//struct Promotion: Codable {
//    var id : Int
//    var keyString : String
//    var availableUsage : Int
//
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case keyString = "key_string"
//        case availableUsage = "available_usage"
//    }
//}
//
//struct PromotionRawData: Codable {
//    var data: [Promotion]
//}
//
//let urlString = "http://159.65.135.188:9670/promo/list"
//guard let url = URL(string: urlString) else {PlaygroundPage.current.finishExecution()}
//var promotions  : [Promotion] = []
//
//URLSession.shared.dataTask(with: url) { (data, response, error) in
//    guard error == nil else {
//        return
//    }
//    guard let data = data  else {
//        return
//    }
//
//    guard (response as! HTTPURLResponse).statusCode == 200 else {
//        return
//    }
//    do {
//        let promotionRawData = try JSONDecoder().decode(PromotionRawData.self, from: data)
//        DispatchQueue.main.async {
//            promotions = promotionRawData.data
//            promotions.forEach{print("\($0.keyString)")}
//
//        }
//        // tableView.reloadData()
//    } catch {
//        print(error.localizedDescription)
//    }
//    }.resume()


//login

PlaygroundPage.current.needsIndefiniteExecution = true

struct UserInfo: Codable {
    var   phoneNumber : String
    var   password : String
    var   latitude : Double
    var   longtitude : Double
    var   deviceId : String
    private enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case password
        case latitude
        case longtitude
        case deviceId = "device_id"
    }
}

var userInfo = UserInfo(phoneNumber: "+84924586555", password: "123456", latitude: 21.0335302, longtitude: 105.7678049, deviceId: "dx9ge6uw6lb6")

var dataUpload = try JSONEncoder().encode(userInfo)

struct LoginResponseRawData : Codable{
    var data : AccessTokenModel
}
    struct AccessTokenModel : Codable {
        var access_token : String
        var client : Client
}

        struct Client : Codable {
            var id: Int
            var phone_number: String
            var display_name: String
        }


let urlString = "http://159.65.135.188:9670/clients/login"
guard let url = URL(string: urlString) else {
    PlaygroundPage.current.finishExecution()
}

var  request = URLRequest(url: url)
request.httpMethod = "POST"
var hose = [Client]()
URLSession.shared.uploadTask(with: request, from: dataUpload) { (data, response, error) in
    guard error == nil else { return }
    guard (response as! HTTPURLResponse).statusCode == 200 else {return}
    guard let data = data else { return  }
    
    do {
        let rawData = try JSONDecoder().decode(LoginResponseRawData.self, from: data)
        DispatchQueue.main.async {
        let hoses = [Client(id: rawData.data.client.id, phone_number: rawData.data.client.phone_number, display_name: rawData.data.client.display_name)]
            hose = hoses
            print(hose)
        }
        print(rawData.data.access_token)
    }catch {
        print(error.localizedDescription)
    }
    }.resume()
