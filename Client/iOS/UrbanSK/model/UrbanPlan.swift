struct UrbanPlan: Decodable {
    var urbanPlanId: String
    var name: String
    var latitude: String
    var longitude: String
    var zoom: String
    var tilesets: [Tileset]
}
