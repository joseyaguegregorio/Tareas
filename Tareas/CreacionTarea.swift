//
//  CreacionTarea.swift
//  Tareas
//
//  Created by Jose María Yagüe on 05/05/2020.
//  Copyright © 2020 Jose María Yagüe. All rights reserved.
//

import SwiftUI
import Foundation

struct CreacionTarea: View {

    //ESTO SE TIENE QUE PONER EN CADA VISTA QUE SE QUIERA GUARDAR COREDATA
    @Environment(\.managedObjectContext) var contexto
    @Environment(\.presentationMode) var atras

    @State private var descripcion: String = ""
    @State private var nombre: String = ""
    @State private var tieneFecha: Bool = false
    @State private var fecha: Date = Date()
    var fechaCompartativaSalida: Date = Date()


    @State var colorLetra = true
    @State var opacidadFecha = true

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }



    var body: some View {
        VStack (alignment:.leading){

            Text("Nombre")
                .bold()
                .padding()
                .padding(.top,30)
                .foregroundColor(colorLetra ?  Color.black : Color.red)
                
                //                .font(.system(size:colorLetra ? 20 : 30))
                .scaleEffect(colorLetra ? 1 : 1.1)
                .animation(
                    Animation.easeOut(duration: 0.9)
                        .repeatCount(1, autoreverses: true
                    )
            )


            TextField("Nombre", text: self.$nombre)
                .padding()
                .onTapGesture {
                    self.colorLetra = true
            }
            Text("Descripcion")
                .bold()
                .padding()
            TextField("Descripcion", text: self.$descripcion)
                .padding()
            //            Text("Prioridad")
            //            TextField("prioridad", value: $prioridad, formatter: NumberFormatter()).padding(38).keyboardType(.numberPad)
            Button(action: {
                self.opacidadFecha.toggle()
            }) {
                Text("\(self.fecha,formatter: dateFormatter)")
                    .bold()
                    .padding()
                    .padding(.top,30)
                    .opacity(0.5)
                    .foregroundColor(Color.black)
            }


            HStack(alignment: .center) {
                Spacer()

                DatePicker("Poner fecha", selection: $fecha, in: Date()...,displayedComponents: .date)
                    .labelsHidden()
                    .environment(\.locale, Locale.init(identifier: "es"))
                    .opacity(opacidadFecha ? 0 : 1 )

//                Text("\(fechaTarea,formatter: dateFormatter)")
                Spacer()
            }

            Spacer()

            Button(action:{
                print(self.fechaCompartativaSalida.description)
                print(self.fecha.description)

//Comparo que sea un dia diferente al actual, ya que si es el actual no se guradara el bool de la fecha, para no mostrarlo en la descripcion
                if !(Calendar.current.isDate(self.fecha, inSameDayAs: self.fechaCompartativaSalida)){
                    print("Mismo dia")
                    self.tieneFecha = true
                }

//                if self.fecha != self.fechaCompartativaSalida {
////                    print("Si")
////                    print("\(self.fecha)")
////                    print("\(self.fechaCompartativaSalida)")
//                    self.tieneFecha = true
//                }
                //Hago todo esto para que no deje guardar sin nombre
                if self.nombre==""{
                    if (self.nombre,self.descripcion) == ("",""){
                        print("No se guardo nada")
                        self.atras.wrappedValue.dismiss()
                    }
                    else if self.descripcion != ""{
                        print("Debes introducir nombre")
                        self.colorLetra = false
                    }
                }
                else{
                    let nuevaTarea = TareasBaseDatos(context: self.contexto)
                    nuevaTarea.nombre = self.nombre
                    nuevaTarea.descripcion = self.descripcion
                    nuevaTarea.fecha = self.fecha
                    nuevaTarea.tieneFecha = self.tieneFecha
                    nuevaTarea.creacion = Date()
                    do{
                        try self.contexto.save()
                        print("Guardado Correctamente")
                        self.atras.wrappedValue.dismiss()
                    }catch let error as NSError {
                        print("Salio un error al guardar", error.localizedDescription)
                    }
                }


            }){
                HStack(alignment: .center) {
                    Spacer()
                    Text("Guardar")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(40)
                    


                    Spacer()
                }
            }


            //          Al ser una sheet este valor deja de existir
            //            .navigationBarTitle("Nueva")
            Spacer()
        }

    }
}

struct CreacionTarea_Previews: PreviewProvider {
    static var previews: some View {
        CreacionTarea()
    }
}
