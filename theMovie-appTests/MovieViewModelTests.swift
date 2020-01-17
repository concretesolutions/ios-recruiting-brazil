import Quick
import Nimble

@testable import theMovie_app

class MovieViewModelTests: QuickSpec {
    
    override func spec() {
        var sut: MovieViewModel!
        var movie: Movie!
        var favoriteMovieManagerMock: FavoriteMovieManagerMock!
        
        
        describe("Given a movie") {
            
            beforeEach {
                movie = self.buildMovie()
                sut = MovieViewModel(movie)
                favoriteMovieManagerMock = FavoriteMovieManagerMock()
                sut.favoriteManager = favoriteMovieManagerMock
            }
            
            it("returns the correct value") {
                expect(sut.id).to(equal(12))
            }
            it("returns the correct name") {
                expect(sut.title).to(equal("John Wick"))
            }
            
            it("build poster path url") {
                expect(sut.posterPath).to(equal(URL(string: "https://image.tmdb.org/t/p/original/image")))
            }
            
            it("should add a favorite") {
                let movieVM = MovieViewModel(self.buildMovie())
                sut.addOrRemoveFavoriteMovie(favoriteMovie: movieVM)
                
                let result = favoriteMovieManagerMock.addFavoriteCalled
                expect(result).to(equal(true))
            }
            
            it("should delete a favorite") {
                let movieVM = MovieViewModel(self.buildFavoriteMovie())
                sut.addOrRemoveFavoriteMovie(favoriteMovie: movieVM)
                
                let result = favoriteMovieManagerMock.deleteFavoriteCalled
                expect(result).to(equal(true))
            }
        }
    }
    
    private func buildMovie() -> Movie! {
        let movie = Movie(id: 12,
                          title: "John Wick",
                          genreIds: [Int](),
                          overview: "Não se mete com meu dog",
                          releaseDate: "0000",
                          posterPath: "/image")
        return movie
    }
    
    private func buildFavoriteMovie() -> Movie! {
           let movie = Movie(id: 111,
                             title: "Captain Marvel",
                             genreIds: [Int](),
                             overview: "Voa e solta raio",
                             releaseDate: "0000",
                             posterPath: "/image")
           return movie
       }
}
