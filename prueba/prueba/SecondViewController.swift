//
//  SecondViewController.swift
//  Prueba
//
//  Created by edgar elias gonzalez lira on 06/04/22.
//

import Foundation
import UIKit

class SecondController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        callAPI {
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Boton superior para regresar a vista principal
    @IBAction func changeView(sender: UIButton){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "ViewController")
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBOutlet var tableView: UITableView!
    
    //inicio de mi estructura a partir de Welcome
    var todoProductos: Welcome!
    var cuenta: Int = 0
    var url: String = ""
    var nombre: String = ""
    var precio: Int = 0
    var categoria: String = ""
    var productos = [Producto]()
    
    func callAPI(completed: @escaping () -> ()){
        let url = URL(string: "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91ai")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do{
                    self.todoProductos
                        = try JSONDecoder().decode(Welcome.self, from: data)
                    self.cuenta = self.todoProductos!.resultado.productos.count
                    self.productos = self.todoProductos!.resultado.productos

                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

extension SecondController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //regresar al viewController Main
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "ViewController")
        self.present(controller, animated: true, completion: nil)
        
        //regresa la información del row seleccionado
        self.nombre = self.todoProductos!.resultado.productos[indexPath.row].nombre
        self.precio = self.todoProductos!.resultado.productos[indexPath.row].precioRegular
        self.categoria = self.todoProductos!.resultado.productos[indexPath.row].codigoCategoria.rawValue
        self.url = self.todoProductos!.resultado.productos[indexPath.row].urlImagenes[0]
        print("Producto: \(self.nombre) \nPrecio: \(self.precio) \nCategoria: \(self.categoria) \nImagen: \(self.url)")
        
    }
}

extension SecondController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cuenta
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //número de lineas para mostrar texto
        cell.textLabel?.numberOfLines = 2
        //formato de la celda
        cell.textLabel?.font = UIFont(name: "Avenir", size: 18)
        //genero mis 13 celdas para los productos, debo llenar con la información
        cell.textLabel?.text =
            (todoProductos.resultado.productos[indexPath.row].nombre)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
