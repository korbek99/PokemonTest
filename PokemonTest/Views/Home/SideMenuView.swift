//
//  SideMenuView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 28-01-26.
//
import SwiftUI
import SwiftData

struct SideMenuView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entrenadores: [Entrenador]
    
    var logoutAction: () -> Void
    var closeMenu: () -> Void
    
    private var currentUsername: String {
        entrenadores.first?.nombre ?? "Entrenador"
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture { closeMenu() }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                    
                    VStack(alignment: .leading) {
                        Text(currentUsername)
                            .font(.title3)
                            .bold()
                        
                        Text("Entrenador Nivel 1")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 100)
                
                Divider().padding(.vertical, 10)
                
                Button(action: performLogout) {
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
    
 
    private func performLogout() {
        
        for entrenador in entrenadores {
            modelContext.delete(entrenador)
        }

        try? modelContext.save()
 
        logoutAction()
    }
}

#Preview {
    SideMenuView(
        logoutAction: { print("Logout") },
        closeMenu: { print("Close") }
    )
    .modelContainer(for: Entrenador.self, inMemory: true)
}
