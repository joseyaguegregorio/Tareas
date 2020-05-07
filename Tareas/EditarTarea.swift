//
//  EditarTarea.swift
//  Tareas
//
//  Created by Jose María Yagüe on 06/05/2020.
//  Copyright © 2020 Jose María Yagüe. All rights reserved.
//

import SwiftUI

struct EditarTarea: View {
    
    //ESTO SE TIENE QUE PONER EN CADA VISTA QUE SE QUIERA GUARDAR COREDATA
    @Environment(\.managedObjectContext) var contexto
    @State private var descripcion: String = ""
    @State private var nombre: String = ""
    var tarea: TareasBaseDatos
    //    @State var prioridad: Int
    @Environment(\.presentationMode) var atras
    @State var colorLetra = true
    
    var body: some View {
        VStack (alignment:.leading){
            
            Text("Nombre")
                .bold()
                .padding()
                .padding(.top,30)
                .font(.system(size:20))
                .foregroundColor(colorLetra ?  Color.black : Color.red)
                .scaleEffect(colorLetra ? 1 : 1.1)
                .animation(
                    Animation.easeOut(duration: 0.9)
                        .repeatCount(1, autoreverses: true
                    )
            )
            TextField("Nombre", text: self.$nombre)
                .padding()
                .onAppear {
                    self.nombre = self.tarea.nombre
                }
                .onTapGesture {
                    self.colorLetra = true
                }
            
            Text("Descripcion")
                .bold()
                .padding()
                .font(.system(size:20))
            TextField("Descripcion", text: self.$descripcion)
                .padding()
                .onAppear {
                    self.descripcion = self.tarea.descripcion
            }
            
            Button(action:{
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
                }else{
                    self.tarea.nombre = self.nombre
                    self.tarea.descripcion = self.descripcion
                    do{
                        try self.contexto.save()
                        print("Editado Correctamente")
                        self.atras.wrappedValue.dismiss()
                    }catch let error as NSError {
                        print("Salio un error al editar", error.localizedDescription)
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
                .navigationBarTitle("Edicion", displayMode: .inline)
            Spacer()
        }
        
    }
}

//struct EditarTarea_Previews: PreviewProvider {
//    static var previews: some View {
//        EditarTarea()
//    }
//}
