

struct Pet {
    let name: String
}


struct Hero: Hashable {
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
