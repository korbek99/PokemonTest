//
//  LoginView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import SwiftUI

struct LoginView: View {
    // Variables locales para que la vista funcione sola
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var loginSuccess: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            // Fondo amarillo que cubre toda la pantalla
            Color.yellow
                .ignoresSafeArea()
            
            NavigationStack {
                VStack(spacing: 25) {
                    
                    Text("Pokemon test")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)

                    Spacer()
                    
                    // Campo correo
                    VStack(alignment: .leading) {
                        Text("Correo electrónico")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        TextField("Ingresa tu correo", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    
                    // Campo password
                    VStack(alignment: .leading) {
                        Text("Contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack {
                            if showPassword {
                                TextField("Ingresa tu contraseña", text: $password)
                            } else {
                                SecureField("Ingresa tu contraseña", text: $password)
                            }
                            
                            Button { showPassword.toggle() } label: {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    }

                    // Botón login
                    Button(action: {
                        // Acción temporal de ejemplo
                        print("Login pulsado")
                    }) {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Enter")
                                .bold()
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.top, 10)
                    
                    // Error
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.callout)
                    }

                    Spacer()
                }
                .padding(20)
                .background(Color.yellow) // Mantiene el estilo
            }
        }
        // Simulación de paso a Home
        .fullScreenCover(isPresented: $loginSuccess) {
            Text("Bienvenido a HomeView")
            // Aquí pondrías tu HomeView() real
        }
    }
}

#Preview {
    LoginView()
}
