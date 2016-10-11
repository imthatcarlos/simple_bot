Location.create(name: "Wells", address: "406 N Wells St, Chicago, IL 60654", latitude: 41.8894321, longitude: -87.6364226)
Location.create(name: "Jackson", address: "73 E Jackson Blvd, Chicago, IL, 60604", latitude: 41.8788515, longitude: -87.6332332)

titles = [
  "Espresso", "Alt Espresso", "Decaf", "Pour Over", "Alt Pour Over", "Chemex for Two", "Batch Brew", "Aeropress"
]

Location.all.each do |loc|
  titles.each do |t|
    loc.items.create(title: t, product: "")
  end
end