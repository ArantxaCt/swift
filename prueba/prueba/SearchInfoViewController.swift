import Foundation
import FoundationNetworking
//import URLSession


class SearchInfoViewController: UIViewController {
    
    //let urlSessionConfiguration = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    let url = URL(string: "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91ai")


    //print("DATA \(url)")

    urlSession.dataTask(with: url!) { data, response, error in
        print("Data \(String(describing: data))")
        print("Response \(String(describing: response))")
        print("Error \(String(describing: error))")
    }.resume()

    do{
        if let json = JSONSerialization.jsonObject(with: url, options: []) as? [String: Any] {
                // try to read out a string array
                if let result = json["resultado"] as? [String] {
                    print(result)
                }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }

    print("Info: \(url)")
}