//
//  SearchViewController.swift
//  BloodMed
//
//  Created by Kenny Cardenas Reyes on 10/25/20.
//  Copyright © 2020 Kenny Cardenas Reyes. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tblSearch: UITableView!
    var allData:Root?
    var interactionArray: [InteraccionesMedicamentosasConTerapiaAnticoagulante]?
    var medicamento: InteraccionesMedicamentosasConTerapiaAnticoagulante?
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        if let localData = self.readLocalFile(forName: "jsonData") {
            self.parse(jsonData: localData)
        }
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return interactionArray?.count ?? 0
        }else{
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SearchCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
        if searching {
            cell.searchName.text = "\(interactionArray![indexPath.row].name ?? "")"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.medicamento = interactionArray![indexPath.row]
        self.performSegue(withIdentifier: "interactionDetail", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let arr = allData?.bloodMed.interaccionesMedicamentosas
        if searchText != "" {
            interactionArray = arr?.filter({$0.name?.folding(options: .diacriticInsensitive, locale: .current).substring(to: ($0.name?.index($0.name!.startIndex,offsetBy: searchText.count))!).lowercased() == searchText.lowercased()})
            searching = true
            tblSearch.reloadData()
        }else{
            interactionArray?.removeAll()
            tblSearch.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "interactionDetail"{
            let destination = segue.destination as! DetailViewController
            destination.medicamentos = self.medicamento
        }
    }
    
}



