//
//  PokemonDetailsView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import SwiftUI

struct PokemonDetailsView: View {
    let pokemon: PokemonResult
    
    @StateObject private var viewModel = PokemonDetailViewModel()
    
    private var rawID: String {
        pokemon.url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                   .components(separatedBy: "/").last ?? "1"
    }

    private var formattedID: String {
        if let idInt = Int(rawID) {
            return String(format: "%03d", idInt)
        }
        return rawID
    }
 
    private var currentDetails: PokemonDetails? {
        viewModel.pokemonList.first
    }

    var body: some View {
        ZStack {
            Color.red.opacity(0.9)
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 120)
                
                VStack(spacing: 20) {
                    
                    if viewModel.isLoading {
                        ProgressView("Cargando detalles...")
                            .padding(.top, 100)
                    } else {
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(Double(currentDetails?.height ?? 0) / 10, specifier: "%.1f") m")
                                    .font(.title3.bold())
                                Text("Altura")
                                    .font(.caption).foregroundColor(.gray)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("\(currentDetails?.baseExperience ?? 0) XP")
                                    .font(.title3.bold())
                                Text("Experiencia")
                                    .font(.caption).foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 70)
                        
                      
                        VStack(alignment: .leading, spacing: 10) {
                            Text("About")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("Este Pokémon tiene una habilidad principal llamada **\(currentDetails?.abilities.first?.ability.name.capitalized ?? "Desconocida")**. ID oficial de registro #\(rawID).")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, 30)
                        
                       
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Información Base")
                                .font(.headline)
                                .padding(.horizontal, 30)

                            HStack(spacing: 0) {
                                StatsColumn(title: "Habilidad", value: currentDetails?.abilities.first?.ability.name.capitalized ?? "N/A")
                                StatsColumn(title: "Registro", value: "#\(rawID)")
                                StatsColumn(title: "Oficial", value: (currentDetails?.isDefault ?? false) ? "Sí" : "No")
                            }
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(35, corners: [.topLeft, .topRight])
            }
            .ignoresSafeArea(edges: .bottom)
            
           
            VStack {
                AsyncImage(url: AppConfig.pokemonImageUrl(for: rawID)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                    case .failure, .empty:
                        ProgressView()
                            .tint(.white)
                            .frame(width: 200, height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.top, 40)
                Spacer()
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
       
        .task {
            await viewModel.fetchPokemons()
        }
    }
}

// MARK: - Subvistas Auxiliares
struct StatsColumn: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.primary)
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Helpers de Diseño
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: - Preview
//#Preview {
//    let mockDetails = PokemonDetails(
//        id: 25,
//        baseExperience: 112,
//        height: 4,
//        isDefault: true,
//        locationAreaEncounters: "",
//        abilities: [
//            AbilitySlot(isHidden: false, slot: 1, ability: NamedResource(name: "static", url: ""))
//        ],
//        cries: Cries(latest: "", legacy: ""),
//        forms: [NamedResource(name: "pikachu", url: "")],
//        gameIndices: [],
//        moves: []
//    )
//    
//    return NavigationStack {
//        PokemonDetailsView(pokemon: mockDetails)
//    }
//}
