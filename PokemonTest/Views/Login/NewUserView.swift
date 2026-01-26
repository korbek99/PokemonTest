//
//  NewUserView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import SwiftUI

struct NewUserView: View {
    @State private var nombre = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: Datos personales
                Section(header: Text("Datos Personales")) {
                    TextField("Nombre", text: $nombre)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Contraseña", text: $password)
                }
                
                Section {
                    Button(action: saveUser) {
                        HStack {
                            Spacer()
                            Text("Registrar Entrenador")
                                .bold()
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.yellow)
                    .foregroundColor(.black)
                }
            }
            .navigationTitle("Nuevo Usuario")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Pokedex Update"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("¡Entendido!"))
                )
            }
        }
    }
    
    // MARK: - Lógica de Guardado
    func saveUser() {
        if nombre.isEmpty || email.isEmpty || password.isEmpty {
            alertMessage = "¡Faltan datos! Un entrenador debe completar su perfil."
            showAlert = true
            return
        }

        alertMessage = "¡Usuario \(nombre) guardado con éxito!"
        showAlert = true
        
        print("""
              --- Nuevo Usuario ---
              Nombre: \(nombre)
              Email: \(email)
              """)
    }
}

#Preview {
    NewUserView()
}
