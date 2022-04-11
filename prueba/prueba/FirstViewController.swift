//
//  ViewController.swift
//  Prueba
//
//  Created by edgar elias gonzalez lira on 05/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    //se arma la vista para la información con imagen
    @IBOutlet weak var vista: UIView?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var todoP: Welcome?
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //oculto las vistas de primera vez
        vista?.isHidden = false
        //asignar valores del row seleccionado
        nameLabel?.text = todoP?.resultado.productos[id].nombre ?? "No data"//regresa nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changeAndLoadView(sender: UIButton){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "SecondController")
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func vista(sender: AnyObject){
        vista?.isHidden = true
    }
    
}

extension UIImageView {
    func downloadedFor(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link)
        else {
            return
        }
        //downloadedFrom(url: url, contentMode: mode)
    }
}
