// 1) შექმენით CreatureType enum-ი სხვადასხვა ტიპის არსებებით (მაგ: fire, water, earth, air, electric …). გამოიყენეთ associated value, რომ თითოეულ ტიპს ჰქონდეს rarity: Double მნიშვნელობა 0-დან 1-მდე. დაამატეთ computed property description, რომელიც დააბრუნებს არსების ტიპის აღწერას. 

enum CreatureType {
    case fire(rarity: Double)
    case water(rarity: Double)
    case earth(rarity: Double)
    case air(rarity: Double)
    case electric(rarity: Double)
    
    
    static func randomRarity(type: CreatureType) -> CreatureType {
        switch type {
        case .fire :
            return .fire(rarity: Double.random(in: 0...1))
        case .water :
            return .water(rarity: Double.random(in: 0...1))
        case .earth :
            return .earth(rarity: Double.random(in: 0...1))
        case .air :
            return .air(rarity: Double.random(in: 0...1))
        case .electric :
            return .electric(rarity: Double.random(in: 0...1))
        }
    }
    var description: String {
        switch self {
        case .fire(let rarity):
            return ("Fire creature with rarity : \(rarity)")
        case .water(let rarity):
            return "Water creature with rarity : \(rarity)"
        case .earth(let rarity):
            return "Earth creature with rarity : \(rarity)"
        case .air(let rarity):
            return "Air creature with rarity : \(rarity)"
        case .electric(let rarity):
            return "Electric creature with rarity : \(rarity)"
        }
    }
    
    var name: String {
        switch self {
        case .fire:
            return "Fire Creature"
        case .water:
            return "Water Creature"
        case .earth:
            return "Earth Creature"
        case .air:
            return "Air Creature"
        case .electric:
            return "Electric Creature"
        }
    }
}

let fireCreature = CreatureType.randomRarity(type: .fire(rarity: 0))
print(fireCreature.description)
print("\n")

// 2) შექმენით პროტოკოლი CreatureStats შემდეგი მოთხოვნებით: var health: Double var attack: Double var defense: Double func updateStats(health: Double, attack: Double, defense: Double) მეთოდი, რომელიც განაახლებს ამ მონაცემებს.

protocol CreatureStats {
    var health: Double { get set }
    var attack: Double { get set }
    var defense: Double { get set }
    func updateStats(health: Double, attack: Double, defense: Double)
}

class Creature: CreatureStats {
    var health: Double
    var attack: Double
    var defense: Double
    
    init(health: Double, attack: Double, defense: Double) {
        self.health = health
        self.attack = attack
        self.defense = defense
    }
    
    func updateStats(health: Double, attack: Double, defense: Double) {
        self.health = health
        self.attack = attack
        self.defense = defense
    }
}

var airCreature = Creature(health: 400, attack: 75, defense: 180)
print("Air Creature Health: \(airCreature.health)")
print("Air Creature Attack: \(airCreature.attack)")
print("Air Creature Defense: \(airCreature.defense)")
airCreature.updateStats(health: 470, attack: 90, defense: 200)
print("\nUpdated the stats of: Air Creature\n")
print("Air Creature Health: \(airCreature.health)")
print("Air Creature Attack: \(airCreature.attack)")
print("Air Creature Defense: \(airCreature.defense)")
print("\n")

// 3) შექმენით კლასი Trainer შემდეგი ფროფერთებით: public let name: String private var creatures: [DigitalCreature] დაამატეთ public მეთოდი add(creature: DigitalCreature) რომლითაც შეძლებთ ახალი არსების დამატებას მასივში, ასევე არსებას საკუთარ თავს (self) დაუსეტავს ტრენერად.

class Trainer {
    public let name: String
    private var creatures: [DigitalCreature] = []
    
    init(name: String) {
        self.name = name
    }
    
    public func add(creature: DigitalCreature) {
        creatures.append(creature)
        creature.setToTrainer = self
    }
    
    public func remove(creature: DigitalCreature) {
        creatures = creatures.filter { (currentCreature: DigitalCreature) -> Bool in
            currentCreature !== creature
        }
    }
}


// 4) შექმენით კლასი DigitalCreature, რომელიც დააკმაყოფილებს CreatureStats პროტოკოლს. დაამატეთ public let name: String, public let type: CreatureType, public var level: Int, public var experience: Double, weak public var trainer: Trainer?. დაამატეთ deinit მეთოდი, რომელიც დაბეჭდავს შეტყობინებას არსების წაშლისას. 

class DigitalCreature: CreatureStats {
    public let name: String
    public let type: CreatureType
    public var level: Int
    public var experience: Double
    public var health: Double
    public var attack: Double
    public var defense: Double
    weak public var setToTrainer: Trainer?
    
    init(name: String, type: CreatureType, level: Int, experience: Double, health: Double, attack: Double, defense: Double) {
        self.name = name
        self.type = type
        self.level = level
        self.experience = experience
        self.health = health
        self.attack = attack
        self.defense = defense
    }
    
    func updateStats(health: Double, attack: Double, defense: Double) {
        self.health = health
        self.attack = attack
        self.defense = defense
    }
    
    deinit {
        print("\(name) was removed from the trainer.")
    }
}

var creatureTrainer = Trainer(name: "Creature Trainer")
var waterCreature = DigitalCreature(name: "Water Creature", type: .water(rarity: 0), level: 4, experience: 260, health: 300, attack: 150, defense: 130)

creatureTrainer.add(creature: waterCreature)
creatureTrainer.remove(creature: waterCreature)
print("\n")

// 5) შექმენით CreatureManager კლასი შემდეგი ფუნქციონალით: private var creatures: [DigitalCreature] - არსებების მასივი, public func adoptCreature(_ creature: DigitalCreature) - არსების დამატება, public func trainCreature(named name: String) - კონკრეტული არსების წვრთნა (გაითვალისწინეთ რომ წვრთნა მოხდება მხოლოდ მაშინ თუ არჩეულ არსებას ყავს მწვრთნელი!), public func listCreatures() -> [DigitalCreature] - ყველა არსების სიის დაბრუნება. გააფართოვეთ CreatureManage კლასი მეთოდით func trainAllCreatures(), რომელიც გაწვრთნის ყველა არსებას. 

class CreatureManager {
    private var creatures: [DigitalCreature] = []
    
    init(creatures: [DigitalCreature]) {
        self.creatures = creatures
    }
    
    public func adoptCreature(_ creature: DigitalCreature) {
        creatures.append(creature)
    }
    public func listCreatures() -> [DigitalCreature] {
        return creatures
    }
}

extension CreatureManager {
    public func trainCreature(name: String) {
        for creature in creatures {
            if creature.name == name {
                if creature.setToTrainer != nil {
                    creature.updateStats(health: 500, attack: 250, defense: 170)
                } else {
                    print("\(creature.name) has no trainer")
                }
            }
        }
    }
}


// 6) შექმენით CreatureShop კლასი მეთოდით purchaseRandomCreature() -> DigitalCreature. ეს მეთოდი დააბრუნებს რანდომიზირებულად დაგენერირებულ არსებას. 

class CreatureShop {
    var randomTypes: [CreatureType] = [.fire(rarity: 0), .water(rarity: 0), .earth(rarity: 0), .air(rarity: 0)]
    
    func purchaseRandomCreature() -> DigitalCreature? {
        if let randomType = randomTypes.randomElement() {
            var name = randomType.name
            var level = Int.random(in: 1...100)
            var experience = Double.random(in: 1...10000)
            var health = Double.random(in: 1...200)
            var attack = Double.random(in: 1...500)
            var defense = Double.random(in: 1...500)
            
            var randomCreature = DigitalCreature(name: name, type: randomType, level: level, experience: experience, health: health, attack: attack, defense: defense)
            return randomCreature
        } else {
            print("There are no creatures")
            return nil
        }
    }
}
    
    
// 7 ) შექმენით გლობალური ფუნქცია updateLeaderboard(players: [CreatureManager]) -> [CreatureManager], რომელიც დაალაგებს მოთამაშეებს მათი არსებების ჯამური ძალის მიხედვით.  
    
func updateLeaderBoard(players: [CreatureManager]) -> [CreatureManager] {
    return players.sorted { playerOne, playerTwo in
        var playerOneSum = 0
        for creature in playerOne.listCreatures() {
            playerOneSum += creature.level
        }
        
        var playerTwoSum = 0
        for creature in playerTwo.listCreatures() {
            playerTwoSum += creature.level
        }
        return playerOneSum > playerTwoSum
    }
}

        var creatureEarth = DigitalCreature(name: "Earth Creature", type: .earth(rarity: 0), level: 50, experience: 840, health: 200, attack: 150, defense: 100)
        var creatureWater = DigitalCreature(name: "Water Creature", type: .water(rarity: 0), level: 80, experience: 1000, health: 400, attack: 240, defense: 170)

var playerOne = CreatureManager(creatures: [creatureEarth])
var playerTwo = CreatureManager(creatures: [creatureWater])

var updatedLeaderBoard = updateLeaderBoard(players: [playerOne, playerTwo])
