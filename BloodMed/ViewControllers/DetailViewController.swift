//
//  DetailController.swift
//  BloodMed
//
//  Created by Kenny Cardenas Reyes on 10/23/20.
//  Copyright © 2020 Kenny Cardenas Reyes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var imgTitle: UIView!
    @IBOutlet weak var interactionName: UILabel!
    @IBOutlet weak var interactionType: UILabel!
    
    var medicamentos: InteraccionesMedicamentosasConTerapiaAnticoagulante?
    var tipo: String?
    var interacciones: [Interacciones]?
    var aumDismAlimentosNat: InteraccionesAlimentosNaturales?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarDatos()
    }
    
    func cargarDatos(){
        if medicamentos != nil {
            self.interactionName.text = medicamentos?.name
            self.interactionType.text = medicamentos?.title
            self.interacciones = medicamentos?.interacciones
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let interacciones = medicamentos?.interacciones {
            return interacciones.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InteraccionesCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InteraccionesCell
        
        if let interacciones = self.medicamentos?.interacciones {
            cell.interactionTitle.text = "\(interacciones[indexPath.row].name)"
            cell.interactionDesc.text = "\(interacciones[indexPath.row].description)"
        }
        return cell
    }
}
