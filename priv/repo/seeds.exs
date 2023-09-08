# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     JustTravel.Repo.insert!(%JustTravel.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias JustTravel.{Locations.Location, Tickets.Ticket, Repo}

new_york_location = %Location{
  name: "New York",
  position: %Geo.Point{coordinates: {-73.935242, 40.730610}}
}

sao_paulo_location = %Location{
  name: "São Paulo",
  position: %Geo.Point{coordinates: {-46.633308, -23.550520}}
}

rio_de_janeiro_location = %Location{
  name: "Rio de Janeiro",
  position: %Geo.Point{coordinates: {-43.172896, -22.906847}}
}

new_york_location = Repo.insert!(new_york_location)
sao_paulo_location = Repo.insert!(sao_paulo_location)
rio_de_janeiro_location = Repo.insert!(rio_de_janeiro_location)

ticket = %Ticket{
  name: "Statue of Liberty",
  description:
    "The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor within New York City, in the United States.",
  date: ~D[2023-12-03],
  price: 100.00,
  discount: 10.00,
  child_price: 50.00,
  childs: 1,
  adults: 2,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/statue_of_liberty.jpg",
  location_id: new_york_location.id
}

ticket2 = %Ticket{
  name: "Empire State Building",
  description:
    "The Empire State Building is a 102-story Art Deco skyscraper in Midtown Manhattan in New York City, United States.",
  date: ~D[2023-09-03],
  price: 200.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã"],
  image: "/images/empire_state_building.jpg",
  location_id: new_york_location.id
}

ticket3 = %Ticket{
  name: "Central Park",
  description:
    "Central Park is an urban park in New York City located between the Upper West and Upper East Sides of Manhattan.",
  date: ~D[2023-09-03],
  price: 300.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi"],
  image: "/images/central_park.jpg",
  location_id: new_york_location.id
}

ticket4 = %Ticket{
  name: "Ibirapuera Park",
  description: "Ibirapuera Park is a major urban park in São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 400.00,
  adults: 1,
  comodities: ["Passagem aérea"],
  image: "/images/ibirapuera_park.jpg",
  location_id: sao_paulo_location.id
}

ticket5 = %Ticket{
  name: "São Paulo Museum of Art",
  description:
    "The São Paulo Museum of Art is an art museum located on Paulista Avenue in the city of São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 500.00,
  adults: 1,
  comodities: nil,
  image: "/images/sao_paulo_museum_of_art.jpg",
  location_id: sao_paulo_location.id
}

ticket6 = %Ticket{
  name: "Copacabana Beach",
  description:
    "Copacabana Beach is a 4 km long beach located in the neighborhood of the same name in the city of Rio de Janeiro, Brazil.",
  date: ~D[2023-09-03],
  price: 600.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/copacabana_beach.jpg",
  location_id: rio_de_janeiro_location.id
}

ticket7 = %Ticket{
  name: "Christ the Redeemer",
  description:
    "Christ the Redeemer is an Art Deco statue of Jesus Christ in Rio de Janeiro, Brazil, created by French sculptor Paul Landowski and built by Brazilian engineer Heitor da Silva Costa, in collaboration with French engineer Albert Caquot.",
  date: ~D[2023-09-03],
  price: 700.00,
  adults: 2,
  childs: 2,
  child_price: 350.00,
  discount: 12.00,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/christ_the_redeemer.jpg",
  location_id: rio_de_janeiro_location.id
}

ticket8 = %Ticket{
  name: "Sugarloaf Mountain",
  description:
    "Sugarloaf Mountain is a peak situated in Rio de Janeiro, Brazil, at the mouth of Guanabara Bay on a peninsula that juts out into the Atlantic Ocean.",
  date: ~D[2023-09-03],
  price: 800.00,
  adults: 1,
  comodities: nil,
  image: "/images/sugarloaf_mountain.jpg",
  location_id: rio_de_janeiro_location.id
}

ticket9 = %Ticket{
  name: "Tijuca Forest",
  description:
    "The Tijuca Forest is a tropical rainforest in the city of Rio de Janeiro, Brazil.",
  date: ~D[2023-09-03],
  price: 900.00,
  adults: 1,
  comodities: ["Passagem aérea"],
  image: "/images/tijuca_forest.jpg",
  location_id: rio_de_janeiro_location.id
}

ticket10 = %Ticket{
  name: "Ipanema Beach",
  description:
    "Ipanema is a neighborhood located in the South Zone of the city of Rio de Janeiro, Brazil, between Leblon and Arpoador.",
  date: ~D[2023-09-03],
  price: 1000.00,
  adults: 1,
  child_price: 500.00,
  comodities: ["Passagem aérea", "Wi-fi"],
  childs: 1,
  image: "/images/ipanema_beach.jpg",
  location_id: rio_de_janeiro_location.id
}

ticket11 = %Ticket{
  name: "São Paulo Cathedral",
  description:
    "The São Paulo See Metropolitan Cathedral --" <>
      "also known as the Metropolitan Cathedral of Our Lady of the Assumption or" <>
      "as the Cathedral Square of São Paulo -- is the cathedral of the Roman Catholic Archdiocese of São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 1100.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã"],
  image: "/images/sao_paulo_cathedral.jpg",
  location_id: sao_paulo_location.id
}

ticket12 = %Ticket{
  name: "São Paulo Zoo",
  description:
    "The São Paulo Zoo Foundation, is a zoo located in the district of Água Funda, on the south side of the city of São Paulo, in the state of São Paulo, in Brazil.",
  date: ~D[2023-09-03],
  price: 1200.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/sao_paulo_zoo.jpg",
  location_id: sao_paulo_location.id
}

ticket13 = %Ticket{
  name: "São Paulo Museum of Modern Art",
  description: "The São Paulo Museum of Modern Art, is located in Ibirapuera Park, São Paulo.",
  date: ~D[2023-09-03],
  price: 1300.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi"],
  image: "/images/sao_paulo_museum_of_modern_art.jpg",
  location_id: sao_paulo_location.id
}

ticket14 = %Ticket{
  name: "São Paulo Museum of Image and Sound",
  description:
    "The São Paulo Museum of Image and Sound is a public museum dedicated to audiovisual content, located in the city of São Paulo.",
  date: ~D[2023-09-03],
  price: 1400.00,
  adults: 1,
  comodities: ["Quarto"],
  image: "/images/sao_paulo_museum_of_image_and_sound.jpg",
  location_id: sao_paulo_location.id
}

ticket15 = %Ticket{
  name: "São Paulo Museum of Sacred Art",
  description:
    "The São Paulo Museum of Sacred Art is a museum located in the city of São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 1500.00,
  adults: 1,
  comodities: ["Café da manhã", "Quarto"],
  image: "/images/sao_paulo_museum_of_sacred_art.jpg",
  location_id: sao_paulo_location.id
}

ticket16 = %Ticket{
  name: "São Paulo Museum of Art",
  description:
    "The São Paulo Museum of Art is an art museum located on Paulista Avenue in the city of São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 1600.00,
  adults: 1,
  comodities: ["Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/sao_paulo_museum_of_art.jpg",
  location_id: sao_paulo_location.id
}

ticket17 = %Ticket{
  name: "São Paulo Museum of Archaeology and Ethnology",
  description:
    "The São Paulo Museum of Archaeology and Ethnology is a museum located in the city of São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 1700.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/sao_paulo_museum_of_archaeology_and_ethnology.jpg",
  location_id: sao_paulo_location.id
}

ticket18 = %Ticket{
  name: "São Paulo Museum of Zoology",
  description:
    "The São Paulo Museum of Zoology is a museum located in the city of São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 1800.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/sao_paulo_museum_of_zoology.jpg",
  location_id: sao_paulo_location.id
}

ticket19 = %Ticket{
  name: "São Paulo Museum of the Portuguese Language",
  description:
    "The São Paulo Museum of the Portuguese Language is an interactive Portuguese language--" <>
      "themed museum, located in the city of São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 1900.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/sao_paulo_museum_of_the_portuguese_language.jpg",
  location_id: sao_paulo_location.id
}

ticket20 = %Ticket{
  name: "São Paulo Museum of the Resistance",
  description:
    "The São Paulo Museum of the Resistance is a museum located in the city of São Paulo, Brazil.",
  date: ~D[2023-09-03],
  price: 2000.00,
  adults: 1,
  comodities: ["Passagem aérea", "Wi-fi", "Café da manhã", "Quarto"],
  image: "/images/sao_paulo_museum_of_the_resistance.jpg",
  location_id: sao_paulo_location.id
}

Repo.insert!(ticket)
Repo.insert!(ticket2)
Repo.insert!(ticket3)
Repo.insert!(ticket4)
Repo.insert!(ticket5)
Repo.insert!(ticket6)
Repo.insert!(ticket7)
Repo.insert!(ticket8)
Repo.insert!(ticket9)
Repo.insert!(ticket10)
Repo.insert!(ticket11)
Repo.insert!(ticket12)
Repo.insert!(ticket13)
Repo.insert!(ticket14)
Repo.insert!(ticket15)
Repo.insert!(ticket16)
Repo.insert!(ticket17)
Repo.insert!(ticket18)
Repo.insert!(ticket19)
Repo.insert!(ticket20)
