//
//  DetailNatAli.swift
//  BloodMed
//
//  Created by Kenny Cardenas Reyes on 10/24/20.
//  Copyright © 2020 Kenny Cardenas Reyes. All rights reserved.
//


import UIKit

class DetailNatAliViewController: UIViewController {
    
    

    @IBOutlet weak var interactionName: UILabel!
    
    var interacciones: [InteraccionesAlimentos]?
    var aumDismAlimentosNat: InteraccionesAlimentosNaturales?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarDatos()
    }
    
    func cargarDatos(){
        if aumDismAlimentosNat != nil {
            self.interactionName.text = aumDismAlimentosNat?.name
            self.interacciones = aumDismAlimentosNat?.interacciones
        }
    }
}

extension DetailNatAliViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let interacciones = aumDismAlimentosNat?.interacciones {
            return interacciones.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InteraccionesCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InteraccionesCell
        
        if let interacciones = self.aumDismAlimentosNat?.interacciones {
            cell.interactionTitle.text = "\(interacciones[indexPath.row].name)"
            if interacciones[indexPath.row].description != nil {
                cell.interactionDesc.text = "\(interacciones[indexPath.row].description ?? "")"
            }else{
                cell.interactionDesc.removeFromSuperview()
            }
        }
        return cell
    }
}

