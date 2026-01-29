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

    private var currentDetails: PokemonDetails? {
        viewModel.pokemonList.first
    }

    var body: some View {
        ZStack {
            Color.red.opacity(0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer(minLength: 220)
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Cargando detalles...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 30) {

                                HStack {
                                    VStack(spacing: 4) {
                                        Text("\(Double(currentDetails?.height ?? 0) / 10, specifier: "%.1f") m")
                                            .font(.title3.bold())
                                        Text("Altura").font(.caption).foregroundColor(.gray)
                                    }
                                    Spacer()
                                    VStack(spacing: 4) {
                                        Text("\(currentDetails?.baseExperience ?? 0) XP")
                                            .font(.title3.bold())
                                        Text("Experiencia").font(.caption).foregroundColor(.gray)
                                    }
                                }
                                .padding(.top, 60)
                                .padding(.horizontal, 40)
 
                                VStack(spacing: 15) {
                                    Text("About")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                    
                                    HStack(spacing: 0) {
                                        StatsColumn(title: "Weight", icon: "scalemass", value: "6.9 kg")
                                        StatsColumn(title: "Height", icon: "ruler", value: "0.7 m")
                                        StatsColumn(title: "Moves", icon: "bolt.fill", value: "Moves 1")
                                    }
                                    
                                    Text("Este Pokémon tiene una habilidad principal llamada **\(currentDetails?.abilities.first?.ability.name.capitalized ?? "Desconocida")**. Actualmente registrado bajo el ID oficial #\(rawID).")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                        .lineSpacing(4)
                                        .padding(.top, 10)
                                }
                                .padding(.horizontal, 30)
                                
                                VStack(alignment: .center, spacing: 15) {
                                    Text("Base Stats")
                                        .font(.headline)
                                        .padding(.horizontal, 30)
                                        .foregroundColor(.blue)
                                    
                                    VStack(spacing: 12) {
                                        StatRow(label: "HP", value: 45, max: 255, color: .blue)
                                        StatRow(label: "ATK", value: 49, max: 255, color: .blue)
                                        StatRow(label: "DEF", value: 49, max: 255, color: .blue)
                                        StatRow(label: "SATK", value: 65, max: 255, color: .blue)
                                        StatRow(label: "SDEF", value: 65, max: 255, color: .blue)
                                        StatRow(label: "SPD", value: 45, max: 255, color: .blue)
                                    }
                                    .padding(.horizontal, 30)
                                }
                                .padding(.top, 20)

                                Color.clear.frame(height: 50)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                        ProgressView().tint(.white).frame(width: 200, height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.top, 20)
                Spacer()
            }
        }
        .padding(.top, 10)
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task {
            await viewModel.fetchPokemons()
        }
    }
}

// MARK: - Subvistas Auxiliares CORREGIDAS
struct StatsColumn: View {
    let title: String
    let icon: String?
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 4) {
                if let iconName = icon {
                    Image(systemName: iconName)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Text(value)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.primary)
            }
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct StatRow: View {
    let label: String
    let value: Int
    let max: Int
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Text(label)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.gray)
                .frame(width: 40, alignment: .leading)
            
            Text("\(value)")
                .font(.system(size: 12, weight: .medium))
                .frame(width: 30, alignment: .trailing)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(color.opacity(0.2))
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 5)
                        .fill(color)
                        .frame(width: geometry.size.width * CGFloat(value) / CGFloat(max), height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}

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
#Preview {
  
    let mockPokemon = PokemonResult(
        name: "pikachu",
        url: "https://pokeapi.co/api/v2/pokemon/25/"
    )
    return NavigationStack {
        PokemonDetailsView(pokemon: mockPokemon)
    }
}
