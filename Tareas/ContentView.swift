//
//  ContentView.swift
//  Tareas
//
//  Created by Jose María Yagüe on 05/05/2020.
//  Copyright © 2020 Jose María Yagüe. All rights reserved.
//

import SwiftUI
struct EjemploTarea: Identifiable{
    var id: UUID = UUID()
    var nombre: String
    init(nombre:String){
        self.nombre = nombre
    }
}

struct ContentView: View {
    @ State var TareasEj: [EjemploTarea] = [EjemploTarea(nombre: "Lenguaje de Marcas"),EjemploTarea(nombre: "Comprar"),EjemploTarea(nombre: "Programacion")]
    @State var verSheet = false

//ESTO SE TIENE QUE PONER EN CADA VISTA QUE SE QUIERA USAR CORE DATA
    @Environment(\.managedObjectContext) var contexto
//Necesario para acceder a la BBDD y a la vez se hace un ordenamiento por nombre ascendente
    @FetchRequest(entity: TareasBaseDatos.entity(), sortDescriptors:
        [NSSortDescriptor(keyPath: \TareasBaseDatos.nombre, ascending: true)]) var Tareas : FetchedResults<TareasBaseDatos>




    // Para editar el barTittle
    init() {
        //Use this if NavigationBarTitle is with Large Font
        // UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]

        //Use this if NavigationBarTitle is with displayMode = .inline
        // UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
        UINavigationBar.appearance().tintColor = UIColor.black
        //fondocolor
        UINavigationBar.appearance().barTintColor = UIColor.white
    }
    var body: some View {


        VStack{
            NavigationView{
                List{
                    ForEach(Tareas){tarea in

                        NavigationLink(destination: TareaDescripcion(tarea: tarea)) {
                            Text(tarea.nombre)
                        }
                    }.onDelete { (IndexSet) in
                        let borrarTarea = self.Tareas[IndexSet.first!]
                        self.contexto.delete(borrarTarea)
                        do{
                            try self.contexto.save()
                        }catch let error as NSError {
                            print("algo salio mal al borrar", error.localizedDescription )
                        }
                    }
                }
                .navigationBarTitle("Tareas", displayMode: .large)

                .foregroundColor(.black)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.verSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
//                            .padding(.top,22)
                            .padding()
                    }
                )
//                Ha sido sustiduido por sheet
                //                .navigationBarItems(trailing:
                //                    NavigationLink(destination: CreacionTarea(descripcionIntroducida: ""), label: {
                //                        Image(systemName: "plus.circle.fill")
                //                            .resizable()
                //                            .scaledToFit()
                //                            .frame(width: 25, height: 25, alignment: .center)
                //                            .padding(.top,22)
                //                            .padding()
                //                    })
                //                )
            }.sheet(isPresented: $verSheet) {
//Si no le paso .environment(\.managedObjectContext, self.contexto) falla al guardar, en el tutorial no lo hace con sheet
                CreacionTarea().environment(\.managedObjectContext, self.contexto)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

