Model/GenreList : Line 11 -> var genr: [Genre] -> var genres: [Genre]

Model/Genre: Line 11 -> var id : Bool -> var id : Int

Networking/GenreManage: Line 19 : uncomment -> // completion(genreList)

Networking/MovieManager: Line 30 -> add .resume()

Presenter/MovieCollectionView/MovieCollectionView: 

Line 57 - > let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCll" -> let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell"

Line 20 -> movieCollectionView.register(UINib(nibName: "MovieCollectionViewCelll", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell") -> movieCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")

MovieCollectionView height constraint has to be set to its original size

NowInTheaters/NowInTheaters: 

Line 28 -> tableView.register(UINib(nibName: "MovieCollectionVie", bundle: nil), forCellReuseIdentifier: "MovieCollectionView") -> tableView.register(UINib(nibName: "MovieCollectionView", bundle: nil), forCellReuseIdentifier: "MovieCollectionView")