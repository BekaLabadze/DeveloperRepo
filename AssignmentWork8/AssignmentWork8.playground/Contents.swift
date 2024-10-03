import UIKit

// 1) შექმენით Genre ტიპის enum, რომელიც შეიცავს ფილმის ჟანრებს, მაგალითად: action, drama, comedy, thriller და სხვა. შექმენით ძირითადი კლასი Film, რომელსაც ექნება შემდეგი თვისებები: title - ფილმის სახელი, releaseYear— გამოშვების წელი, genre — ფილმის ჟანრი, revenue - შემოსავალი მეთოდი description(), რომელიც დაბეჭდავს ინფორმაციას ფილმზე.

enum Genre {
    case action
    case drama
    case comedy
    case thriller
    case scifi
}

class Film {
    var title: String
    var releaseYear: Int
    var genre: Genre
    var revenue: Double
    
    init(title: String, releaseYear: Int, genre: Genre, revenue: Double) {
        self.title = title
        self.releaseYear = releaseYear
        self.genre = genre
        self.revenue = revenue
    }
    
    func description() {
        print("Title: \(title)")
        print("Release Year: \(releaseYear)")
        print("Genre: \(genre)")
        print("Revenue: \(revenue)")
    }
    
    static func removeFilm(films: [Film]) -> [Film] {
        var uniqueTitles = [Film]()
        
        for film in films {
            var checkTitle = uniqueTitles.contains { (existingFilm) -> Bool in
                if existingFilm.title == film.title {
                    return true
                } else {
                    return false
                }
            }
            if checkTitle == false {
                uniqueTitles.append(film)
            }
        }
        return uniqueTitles
    }
}

var filmDescription = Film(title: "Gladiator", releaseYear: 2000, genre: .action, revenue: 457000000.0)

filmDescription.description()

print("\n")

// 2) შექმენით კლასი Person, რომელსაც აქვს შემდეგი თვისებები: name — პიროვნების სახელი birthYear — დაბადების წელი. მეთოდი getAge რომელიც დაიანგარიშებს და დააბრუნებს ამ პიროვნების ასაკს მოცემულ წელს.

class Person {
    var name: String
    var birthYear: Int
    
    init(name: String, birthYear: Int) {
        self.name = name
        self.birthYear = birthYear
    }
    
    func getAge() {
        birthYear = 2024 - birthYear
        print("\(name) is \(birthYear) years old")
    }
}

var personAge = Person(name: "Gio", birthYear: 1999)
personAge.getAge()

print("\n")

// 3) Film კლასში შექმენით ფუნქცია removeFilm რომელიც პარამეტრად მიიღებს ფილმების მასივს და დასახელებას, ფუნქციამ უნდა წაშალოს მასივში თუ მოიძებნა მსგავსი დასახელების ფილმი.

var titlesToCheck = [Film(title: "Gladiator", releaseYear: 2000, genre: .action, revenue: 457000000.0),
                     Film(title: "The Hangover", releaseYear: 2009, genre: .comedy, revenue: 467000000.0),
                     Film(title: "Gladiator", releaseYear: 2000, genre: .action, revenue: 457000000.0)]


var uniqueFilms = Film.removeFilm(films: titlesToCheck)

for finalTitles in uniqueFilms {
    print("\n")
    finalTitles.description()
}

print("\n")

// 4) შექმენით კლასი Actor, რომელიც არიას Person კლასის მემკვიდრე კლასი Actor-ს უნდა ჰქონდეს actedFilms  მსახიობის მიერ ნათამაშები ფილმების სია და მეთოდი რომელიც მსახიობის მიერ ნათამაშებ ფილმებს დაამატებს სიაში.

class Actor: Person {
    var actedFilms: [String]
    
    init(name: String, birthYear: Int, actedFilms: [String]) {
        self.actedFilms = actedFilms
        super.init(name: name, birthYear: birthYear)
    }
    
    init(name: String, birthYear: Int, actedFilms: String) {
        self.actedFilms = [actedFilms]
        super.init(name: name, birthYear: birthYear)
    }
    
    func addMovies(movies: String) {
        actedFilms.append(movies)
    }
}

let filmsList = Actor(name: "Keanu Reeves", birthYear: 1964, actedFilms: ["Constantine", "The Matrix"])
print(filmsList.actedFilms)
filmsList.addMovies(movies: "John Wick")
print(filmsList.actedFilms)

print("\n")

// 5) შექმენი Director კლასი, რომელიც ასევე Person-ის მემკვიდრეა და ექნება directedFilms რეჟისორის მიერ გადაღებული ფილმების სია და totalRevenue რეჟისორის ჯამური შემოსავალი. დაამატე მეთოდი რომელიც რეჟისორის მიერ გადაღებულ ფილმებს დაამატებს და დაითვლის თითოეული ფილმისთვის ჯამურ შემოსავალს.

class Director: Person {
    var directedFilms: [String]
    var totalRevenue: Double
    
    init(directedFilms: [String], totalRevenue: Double) {
        self.directedFilms = ["Inception", "Interstellar"]
        self.totalRevenue = totalRevenue
        super.init(name: "Christopher Nolan", birthYear: 1970)
    }
    
    func addMovie(title: String, revenue: Double) {
        directedFilms.append(title)
        totalRevenue += revenue
    }
}


let director = Director(directedFilms: ["Inception", "Interstellar"], totalRevenue: 1513000000.0)

print("\(director.directedFilms) - total revenue : \(director.totalRevenue)")
director.addMovie(title: "The Prestige", revenue: 109000000.0)
print("\(director.directedFilms) - total revenue : \(director.totalRevenue)")

print("\n")

// 6) შექმენით 5 ფილმის და 5 მსახიობის ობიექტები და Dictionary, რომელშიც key იქნება მსახიობის სახელი, ხოლო მნიშვნელობებად მიიღებს იმ ფილმების სიას, რომლებშიც მონაწილეობს ეს მსახიობი.

var gladiator = Film(title: "Gladiator", releaseYear: 2000, genre: .action, revenue: 457000000.0)
var matrix = Film(title: "The Matrix", releaseYear: 1999, genre: .scifi, revenue: 463000000.0)
var bladerunner = Film(title: "Bladerunner", releaseYear: 1982, genre: .scifi, revenue: 33800000.0)
var interstellar = Film(title: "Interstellar", releaseYear: 2014, genre: .scifi, revenue: 677000000.0)
var inception = Film(title: "Inception", releaseYear: 2010, genre: .scifi, revenue: 836000000.0)

var joaquinPhoenix = Actor(name: "Joaquin Phoenix", birthYear: 1974, actedFilms: "Gladiator")
var keanuReeves = Actor(name: "Keanu Reeves", birthYear: 1964, actedFilms: "The Matrix")
var harrisonFord = Actor(name: "Harrison Ford", birthYear: 1942, actedFilms: "Bladerunner")
var anneHathaway = Actor(name: "Anne Hathaway", birthYear: 1982, actedFilms: "Interstellar")
var cillianMurphy = Actor(name: "Cillian Murphy", birthYear: 1976, actedFilms: "Inception")


var actorsInMovies: [String: [String]] = [joaquinPhoenix.name:joaquinPhoenix.actedFilms,
                                          keanuReeves.name:keanuReeves.actedFilms,
                                          harrisonFord.name:harrisonFord.actedFilms,
                                          anneHathaway.name:anneHathaway.actedFilms,
                                          cillianMurphy.name:cillianMurphy.actedFilms]

func actorsAndMovies(actors: [String: [String]]) {
    for (actorName, movieTitle) in actors {
        print("\(actorName) - \(movieTitle)")
    }
}

actorsAndMovies(actors: actorsInMovies)

print("\n")

// 7) გამოიყენეთ map, იმისთვის რომ დაბეჭდოთ ყველა ფილმის სათაურების სია ამავე ფილმების მასივიდან

var onlyMovieTitles = actorsInMovies.map { (actor, titles) in
    return titles
}

print(onlyMovieTitles)

print("\n")

// 8) reduce ფუნქციის გამოყენებით დაიანგარიშეთ ამ ყველა ფილმების გამოშვების საშუალო წელი.

var listOfFilms = [gladiator, matrix, bladerunner, interstellar, inception]
var sumOfReleaseYears = listOfFilms.reduce(0) { (sum, releaseYear) in
    (sum + releaseYear.releaseYear)
}
var finalSum = sumOfReleaseYears / listOfFilms.count
print(finalSum)
