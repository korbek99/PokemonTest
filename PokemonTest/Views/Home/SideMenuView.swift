//
//  SideMenuView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 28-01-26.
//

import SwiftUI

struct SideMenuView: View {
    
    var username: String
    var logoutAction: () -> Void
    var closeMenu: () -> Void
    
    @State private var goToNewUser = false

    //let session = UserSession.shared
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture { closeMenu() }
            
            VStack(alignment: .leading, spacing: 10) {
      
                NavigationLink(
                    "",
                    destination: NewUserView(),
                    isActive: $goToNewUser
                )
                .hidden()
                
        
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    Text(username)
                        .font(.title3)
                        .bold()
                }
                .padding(.top, 120)
                
                Divider().padding(.vertical, 10)
                
                // 👉 SOLO ADMIN puede ver Agregar Mandante
//                if !session.isAdminOrConsultor {
//                    Button(action: openNewUser) {
//                        HStack {
//                            Image(systemName: "person.badge.plus")
//                            Text("Agregar Mandante")
//                        }
//                        .font(.title3)
//                        .foregroundColor(.black)
//                    }
//                }
                
                // Logout
                Button(action: logoutAction) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                        Text("Cerrar sesión")
                    }
                    .font(.title3)
                    .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: 260)
            .background(Color.white)
            .shadow(radius: 5)
        }
    }
    
    // 👉 FUNCIÓN INTERNA
    private func openNewUser() {
        goToNewUser = true
        closeMenu()
    }
}


#Preview {
    SideMenuView(
        username: "Jose Bustos",
        logoutAction: { print("Logout tap") },
        closeMenu: { print("Close menu tap") }
    )
}



