//
//  NewUserView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import SwiftUI
import SwiftData

struct NewUserView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    var onFinished: () -> Void
    
    @State private var nombre = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Datos Personales")) {
                    TextField("Nombre", text: $nombre)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never) 
                    SecureField("Contraseña", text: $password)
                }
                
                Section {
                    Button(action: saveUser) {
                        HStack {
                            Spacer()
                            Text("Registrar Entrenador").bold()
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.red)
                    .foregroundColor(.white)
                }
            }
            .navigationTitle("Nuevo Usuario")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Pokedex Update"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("¡A la aventura!")) {
                        // 2. Si el mensaje es de éxito, disparamos el cambio de flujo
                        if alertMessage.contains("éxito") {
                            onFinished()
                        }
                    }
                )
            }
        }
    }
    
    func saveUser() {
        if nombre.isEmpty || email.isEmpty || password.isEmpty {
            alertMessage = "¡Faltan datos! Un entrenador debe completar su perfil."
            showAlert = true
            return
        }

        let nuevoEntrenador = Entrenador(nombre: nombre, email: email, password: password)
        modelContext.insert(nuevoEntrenador)
        
        do {
            try modelContext.save()
            alertMessage = "¡Usuario \(nombre) guardado con éxito!"
            showAlert = true
        } catch {
            alertMessage = "Error al guardar el entrenador."
            showAlert = true
        }
    }
}

#Preview {
    NewUserView(onFinished: {})
        .modelContainer(for: Entrenador.self, inMemory: true)
}

