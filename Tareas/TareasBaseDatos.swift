//
//  TareasBaseDatos.swift
//  Tareas
//
//  Created by Jose María Yagüe on 05/05/2020.
//  Copyright © 2020 Jose María Yagüe. All rights reserved.
//

import Foundation
import CoreData

class TareasBaseDatos: NSManagedObject, Identifiable{
    @NSManaged public var nombre: String
    @NSManaged public var descripcion: String
    @NSManaged public var fecha: Date
    @NSManaged public var creacion: Date
    @NSManaged public var tieneFecha: Bool
}


