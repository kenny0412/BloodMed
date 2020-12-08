//
//  BloodMedData.swift
//  BloodMed
//
//  Created by Kenny Cardenas Reyes on 9/16/20.
//  Copyright © 2020 Kenny Cardenas Reyes. All rights reserved.
//

import Foundation

struct Root: Codable {
    let bloodMed: BloodMed
}
struct BloodMed: Codable  {
    var alimentosConInteraccion: [InteraccionesAlimentosNaturales]
    var medNaturalesConInteraccion: [InteraccionesAlimentosNaturales]
    var interaccionesMedicamentosas: [InteraccionesMedicamentosasConTerapiaAnticoagulante]?

    
    enum CodingKeys: String, CodingKey {
        case alimentosConInteraccion = "alimentos"
        case medNaturalesConInteraccion = "Medicamentos_naturales"
        case interaccionesMedicamentosas = "Interacciones_anticuagulantes"

    }
}

struct InteraccionesAlimentosNaturales: Codable {
    var  name: String?
    var  interacciones: [InteraccionesAlimentos]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case interacciones = "interacciones"
    }
}

struct AumentanEfectoAnticoagulante: Codable  {
    var id: Int
    var name: String
}

struct DisminuyenEfectoAnticoagulante: Codable  {
    var id: Int
    var name: String
}

struct InteraccionesMedicamentosasConTerapiaAnticoagulante: Codable  {
    var  name: String?
    var  title: String?
    var  interacciones: [Interacciones]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case title = "title"
        case interacciones = "interacciones"
    }
}

struct Apixaban:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Bemiparina:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Clopidogrel:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Dabigatran:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Heparina:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Pentoxifilina:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Rivaroxaban:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Ticagrelor:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Triflusal:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct Warfarina:Codable  {
    var description: String
    var id:          Int
    var name:       String
}

struct AcidoAcetilSalicílico:Codable  {
    var name: String
    var interacciones: [Interacciones]?
}

struct Interacciones:Codable {
    var description: String
    var id:          Int
    var name:       String
}

struct InteraccionesAlimentos:Codable {
    var id:          Int
    var name:        String
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"

    }
}


struct MedicamentosNaturalesUtilizadosEnCostaRicaQueInteraccionanConLaTerapiaAnticoagulante: Codable {
    var  name: String?
    var  interacciones: [Interacciones]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case interacciones = "interacciones"
    }
}
