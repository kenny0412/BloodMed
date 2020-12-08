//
//  ViewController.swift
//  BloodMed
//
//  Created by Kenny Cardenas Reyes on 9/14/20.
//  Copyright © 2020 Kenny Cardenas Reyes. All rights reserved.
//

import UIKit
import SwiftyToolTip

class ViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    var allData:Root?
    var medicamentos: InteraccionesMedicamentosasConTerapiaAnticoagulante?
    var aumDismAlimentosNat: InteraccionesAlimentosNaturales?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let localData = self.readLocalFile(forName: "jsonData") {
            self.parse(jsonData: localData)
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(Root.self,from: jsonData)
            self.allData = decodedData;
            print(decodedData)
        } catch {
            print(error)
        }
    }
    
    func showNavController(){
        performSegue(withIdentifier: "showSplash", sender: self)
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0,y:0,width:tableView.frame.width,height:40))
        let label = UILabel(frame: CGRect(x:15,y:0,width: view.frame.width - 15,height:40))
        if section == 0 {
            view.layer.addBorder(edge: UIRectEdge.left, color: UIColor.init(red: 100, green: 0, blue: 0, alpha: 0.3), thickness: 5)
                label.text = "Interacciones con medicamentos"
            label.font = label.font.withSize(20)
        }else if section == 1{
            view.layer.addBorder(edge: UIRectEdge.left, color: UIColor.init(red: 180, green: 0, blue: 0, alpha: 0.7), thickness: 5)
                label.text = "Interacciones M.natural"
            label.font = label.font.withSize(20)
        }else{
            view.layer.addBorder(edge: UIRectEdge.left, color: UIColor.init(red: 255, green: 0, blue: 0, alpha: 1), thickness: 5)
                label.text = "Interacciones con alimentos"
            label.font = label.font.withSize(20)
        }
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let anticuagulantes = self.allData?.bloodMed.interaccionesMedicamentosas{
                return anticuagulantes.count
            }
        }else if section == 1 {
            if let anticuagulantes = self.allData?.bloodMed.medNaturalesConInteraccion{
                return anticuagulantes.count
            }
        }
        return self.allData?.bloodMed.alimentosConInteraccion.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnticuagulanteCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnticuagulanteCell
        
        let alimentos = self.allData?.bloodMed.alimentosConInteraccion
        let naturales = self.allData?.bloodMed.medNaturalesConInteraccion
        let medicamentosas = self.allData?.bloodMed.interaccionesMedicamentosas
        
        if indexPath.section == 0 {
            cell.AntCellName.text = "\(medicamentosas![indexPath.row].name ?? "")"
            cell.addToolTip(description: "\(medicamentosas![indexPath.row].name ?? "")",gesture: .longPress)

        }else if indexPath.section == 1 {
            cell.AntCellName.text = "\(naturales![indexPath.row].name ?? "")"
        }else{
            cell.AntCellName.text = "\(alimentos![indexPath.row].name ?? "")"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.medicamentos = allData?.bloodMed.interaccionesMedicamentosas![indexPath.row]
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "interactionDetail", sender: self)
        }else{
            if indexPath.section == 1 {
                self.aumDismAlimentosNat = allData?.bloodMed.medNaturalesConInteraccion[indexPath.row]
            }else{
                self.aumDismAlimentosNat = allData?.bloodMed.alimentosConInteraccion[indexPath.row]
            }
            self.performSegue(withIdentifier: "natAlimDetail", sender: self)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "interactionDetail"{
            let destination = segue.destination as! DetailViewController
            destination.medicamentos = self.medicamentos
        }else if segue.identifier == "natAlimDetail" {
            let destination = segue.destination as! DetailNatAliViewController
            destination.aumDismAlimentosNat = self.aumDismAlimentosNat
        }
    }
}


