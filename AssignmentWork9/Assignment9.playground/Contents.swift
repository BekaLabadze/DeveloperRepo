import UIKit

// 1) შექმენით "Genre" ტიპის enum, რომელიც შეიცავს წიგნის ჟანრებს (მაგ: fiction, nonFiction, mystery, sciFi, biography). დაამატეთ computed property "description", რომელიც დააბრუნებს ჟანრის აღწერას.

enum Genre {
    case fiction
    case nonFiction
    case mystery
    case adventure
    case philosophy
    case fantasy
    case sciFi
    case biography
    
    var description: String {
        switch self {
        case .fiction: return "Fiction"
        case .nonFiction: return "Non-Fiction"
        case .mystery: return "Mystery"
        case .fantasy: return "Fantasy"
        case .sciFi: return "Sci-Fi"
        case .biography: return "Biography"
        case .adventure: return "Adventure"
        case .philosophy: return "Philosophy"
        }
    }
}

var genre = Genre.fiction
print(genre.description)

print("\n")

//2) შექმენით enum "ReadingLevel" მნიშვნელობებით: beginner, intermediate, advanced. შემდეგ შექმენით პროტოკოლი "Readable" შემდეგი მოთხოვნებით: - "title: String" ფროფერთი - "author: String" ფროფერთი - "publicationYear: Int" ფროფერთი - "readingLevel: ReadingLevel" ფროფერთი - "read()" მეთოდი, რომელიც დაბეჭდავს ინფორმაციას წიგნის წაკითხვის შესახებ. მაგ: "გილოცავთ თქვენ ერთ კლიკში წაიკითხეთ წიგნი".


enum ReadingLevel {
    case beginner
    case intermediate
    case advanced
}

protocol Readable {
    var title: String { get }
    var author: String { get }
    var publicationYear: Int { get }
    var readingLevel: ReadingLevel { get }
    func read()
}

// 3) შექმენით სტრუქტურა "Book", რომელიც დააკმაყოფილებს "Readable" პროტოკოლს. დაამატეთ "genre: Genre" ფროფერთი და "description()" მეთოდი, რომელიც დაბეჭდავს სრულ ინფორმაციას წიგნზე.

struct Book: Readable {
    let title: String
    let author: String
    let publicationYear: Int
    let readingLevel: ReadingLevel
    let genre: Genre
    
    func read() {
        print("თქვენ წაიკითხეთ წიგნი : \(title), რომელიც გამოიცა : \(publicationYear) წელს. ავტორი: \(author)")
    }
    func description() {
        print("Title: \(title)\nAuthor: \(author)\nPublication Year: \(publicationYear)\nReading Level: \(readingLevel)\nGenre: \(genre)")
    }
}

var harryPotter = Book(title: "Harry Potter and the Philosopher's Stone", author: "Joanne Rowling", publicationYear: 1997, readingLevel: .beginner, genre: .fantasy)
var dune = Book(title: "Dune", author: "Frank Herbert", publicationYear: 1965, readingLevel: .intermediate, genre: .sciFi)
var lordOfTheRings = Book(title: "The Lord of the Rings", author: "J.R.R. Tolkien", publicationYear: 1954, readingLevel: .intermediate, genre: .fantasy)

harryPotter.read()
print("\n")
dune.description()
print("\n")

// 4) შექმენით "Library" კლასი შემდეგი ფროფერთებით:- "name: String" - ბიბლიოთეკის სახელი - "books: [Book]" - წიგნების მასივი. დაამატეთ მეთოდები: "add(book: Book)" - წიგნის დამატება, "removeBookWith(title: String)" - წიგნის წაშლა სათაურის მიხედვით, "listBooks()" - ყველა წიგნის ჩამონათვალის დაბეჭდვა. გააფართოეთ “Library” კლასი “filterBooks” მეთოდით რომელიც არგუმენტად მიიღებს ქლოჟერს და დააბრუნებს ამ ქლოჟერის გამოყენებით გაფილტრულ წიგნთა მასივს.


class Library {
    var name: String
    var books: [Book]
    
    init(name: String, books: [Book]) {
        self.name = name
        self.books = books
    }
    
    func add(book: Book) {
        books.append(book)
    }
    func removeBookWith(title: String) {
        books.removeAll { book in
            book.title == title
        }
    }
    func listBooks() {
        for book in books {
            print(book.title)
        }
    }
}

var library = Library(name: "Library", books: [harryPotter, lordOfTheRings])
library.listBooks()
library.add(book: dune)
library.listBooks()
library.removeBookWith(title: "Dune")
library.listBooks()

extension Library {
    func filterBooks(genre: (Book) -> Bool) -> [Book] {
        return books.filter { book in
            genre(book)
        }
    }
}

var filteredByGenre = library.filterBooks { book in
    return book.genre == .fantasy
}

for book in filteredByGenre {
    print("Filtered list: \(book.title)")
}
print("\n")

// 5) შექმენით generic ფუნქცია groupBooksByLevel<T: Readable>(_ books: [T]) -> [ReadingLevel: [T]], რომელიც დააჯგუფებს წიგნებს კითხვის დონის მიხედვით. გამოიყენეთ ეს ფუნქცია ბიბლიოთეკის წიგნებზე და დაბეჭდეთ შედეგი.

func groupBooksByLevel<T: Readable>(_ books: [T]) -> [ReadingLevel: [T]] {
    var groupedBooks = [ReadingLevel: [T]]()
    
    for book in books {
        groupedBooks[book.readingLevel, default: []].append(book)
    }
    return groupedBooks
}

var groupedBooks = groupBooksByLevel(library.books)

for (level, books) in groupedBooks {
    print(level)
    for book in books {
        print(book.title)
    }
}
print("\n")

// 6) შექმენით "LibraryMember" კლასი შემდეგი ფროფერთებით: "id: Int" - "name: String" - "borrowedBooks: [Book]", დაამატეთ მეთოდები: "borrowBook(_ book: Book, from library: Library)" - წიგნის გამოწერა ბიბლიოთეკიდან, "returnBook(_ book: Book, to library: Library)" - წიგნის დაბრუნება ბიბლიოთეკაში.

class LibraryMember {
    var id: Int
    var name: String
    var borrowedBooks: [Book]
    var printMessage: Bool
    
    init(id: Int, name: String, borrowedBooks: [Book], printMessage: Bool) {
        self.id = id
        self.name = name
        self.borrowedBooks = borrowedBooks
        self.printMessage = printMessage
    }
    
    func borrowBook(book: Book, from library: Library) {
        if let bookToBorrow = library.books.first(where: { (libraryBook) -> Bool in
            return libraryBook.title == book.title
        }) {
            borrowedBooks.append(bookToBorrow)
            library.books.removeAll(where: { (libraryBook) -> Bool in
                libraryBook.title == book.title
            })
            if printMessage {
                print("Success : \(bookToBorrow.title)")
            }
        } else {
            if printMessage {
                print("Fail")
            }
        }
    }
    
    func returnBook(book: Book, to library: Library) {
        if let bookToReturn = borrowedBooks.first(where: { (borrowedBooks) -> Bool in
            return borrowedBooks.title == book.title
        }) {
            library.add(book: bookToReturn)
            borrowedBooks.removeAll(where: { (libraryBook) -> Bool in
                libraryBook.title == book.title
            })
            if printMessage {
                print("Succesfully returned : \(bookToReturn.title)")
            }
        } else {
            if printMessage {
                print("Fail")
            }
        }
    }
}

var member = LibraryMember(id: 1, name: "Shako", borrowedBooks: [], printMessage: true)
member.borrowBook(book: harryPotter, from: library)
member.returnBook(book: harryPotter, to: library)
print("\n")

// 7) შექმენით მინიმუმ 5 "Book" ობიექტი და 1 "Library" ობიექტი. დაამატეთ წიგნები ბიბლიოთეკაში "add(book:)" მეთოდის გამოყენებით. შემდეგ: გამოიყენეთ "listBooks()" მეთოდი ყველა წიგნის ჩამოსათვლელად, წაშალეთ ერთი წიგნი "removeBookWith(title:)" მეთოდის გამოყენებით, გამოიყენეთ "filterBooks" მეთოდი და დაბეჭდეთ მხოლოდ ის წიგნები, რომლებიც გამოცემულია 2000 წლის შემდეგ.


var harryPotter1 = Book(title: "Harry Potter and the Philosopher's Stone", author: "Joanne Rowling", publicationYear: 1997, readingLevel: .beginner, genre: .fantasy)
var metamorphosis = Book(title: "The Metamorphosis", author: "Franz Kafka", publicationYear: 1915, readingLevel: .intermediate, genre: .philosophy)
var dune1 = Book(title: "Dune", author: "Frank Herbert", publicationYear: 1965, readingLevel: .intermediate, genre: .sciFi)
var aroundTheWorld = Book(title: "Around the World in Eighty Days", author: "Jules Verne", publicationYear: 1873, readingLevel: .beginner, genre: .adventure)
var lordOfTheRings1 = Book(title: "The Lord of the Rings", author: "J.R.R. Tolkien", publicationYear: 1954, readingLevel: .intermediate, genre: .fantasy)

var newLibrary = Library(name: "New Library", books: [])

newLibrary.add(book: harryPotter1)
newLibrary.add(book: metamorphosis)
newLibrary.add(book: dune1)
newLibrary.add(book: aroundTheWorld)
newLibrary.add(book: lordOfTheRings1)

newLibrary.listBooks()
print("\n")
newLibrary.removeBookWith(title: "Harry Potter and the Philosopher's Stone")
newLibrary.listBooks()
print("\n")
var filter = newLibrary.filterBooks { (book) -> Bool in
        return book.publicationYear > 1950
}

for books in filter {
    print(books.title)
}

// 8) შექმენით მინიმუმ 2 "LibraryMember" ობიექტი. თითოეული წევრისთვის: გამოიწერეთ 2 წიგნი "borrowBook(_:from:)" მეთოდის გამოყენებით, დააბრუნეთ 1 წიგნი "returnBook(_:to:)" მეთოდის გამოყენებით. დაბეჭდეთ თითოეული წევრის გამოწერილი წიგნების სია.

var libraryMemberGio = LibraryMember(id: 2, name: "Gio", borrowedBooks: [], printMessage: false)
var libraryMemberMariam = LibraryMember(id: 3, name: "Mariam", borrowedBooks: [], printMessage: false)

libraryMemberGio.borrowBook(book: dune1, from: newLibrary)
libraryMemberGio.borrowBook(book: metamorphosis, from: newLibrary)
libraryMemberGio.returnBook(book: dune1, to: newLibrary)
print("\n")
for books in libraryMemberGio.borrowedBooks {
    print("Gio has : \(books.title)")
}

libraryMemberMariam.borrowBook(book: lordOfTheRings1, from: newLibrary)
libraryMemberMariam.borrowBook(book: aroundTheWorld, from: newLibrary)
libraryMemberMariam.returnBook(book: aroundTheWorld, to: newLibrary)

for books in libraryMemberMariam.borrowedBooks {
    print("Mariam has : \(books.title)")
}
