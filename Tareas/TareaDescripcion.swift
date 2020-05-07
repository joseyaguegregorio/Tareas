//
//  TareaDescripcion.swift
//  Tareas
//
//  Created by Jose María Yagüe on 05/05/2020.
//  Copyright © 2020 Jose María Yagüe. All rights reserved.
//

import SwiftUI

struct TareaDescripcion: View {
    //    var nombre: String
    //    var descripcion: String
    var tarea: TareasBaseDatos
    @Environment(\.presentationMode) var atras
    var dateFormatter: DateFormatter {
         let formatter = DateFormatter()
         formatter.dateStyle = .full
         return formatter
     }

    var body: some View {


        HStack {

            VStack(alignment: .leading){
                Text(self.tarea.nombre).bold()
                    .padding(.vertical,30)
                    .font(.system(size:30))
                    .padding(.horizontal,18)
                Text(self.tarea.descripcion)
                    .padding(.horizontal,30)
//                NavigationLink(destination: EditarTarea(tarea: self.tarea)) {
//                    Text("Editar").padding(30).foregroundColor(.gray)
//                }
                if(self.tarea.tieneFecha){
                    Text("")
                    Text("\(self.tarea.fecha,formatter: dateFormatter)")
                    .padding(.horizontal,30)
                }

                Spacer()
            }
//            .background(Color.red)

            Spacer()

        }
            
            .navigationBarItems(trailing:
                NavigationLink(destination: EditarTarea(tarea: self.tarea), label: {
                    Image(systemName: "paintbrush.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25, alignment: .center)
//                        .padding(.top,22)
                        .padding()
                })
        )
            .navigationBarTitle("Tarea", displayMode: .inline)


    }
}

//struct TareaDescripcion_Previews: PreviewProvider {
//    static var previews: some View {
//        TareaDescripcion(nombre: "Enotnos", descripcion: "Realizar las tareas mandadas en la ultima clase")
//
//    }
//}

