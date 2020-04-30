//
//  MovieDetailsViewModel.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation

enum MovieDetailsViewModelSectionsTypes {
    case header
    case title
    case trailer
    case summary
}

protocol MovieDetailsSection {
    var type: MovieDetailsViewModelSectionsTypes { get }
}

struct MovieDetailsSummarySection: MovieDetailsSection {
    let type = MovieDetailsViewModelSectionsTypes.summary

    let sectionHeadline: String = "Summary"
    let summary: String!

    init?(with movieDetails: MovieDetails) {
        let summary = movieDetails.overview.isEmpty ? movieDetails.tagline : movieDetails.overview
        guard !summary!.isEmpty else {
            return nil
        }

        self.summary = summary
    }
}

struct MovieDetailTitleSection: MovieDetailsSection {
    let type = MovieDetailsViewModelSectionsTypes.title

    let title: String!
    let subtitle: String!
    let rating: String!

    init?(with movieDetails: MovieDetails) {

        guard !movieDetails.title.isEmpty else {
            return nil
        }

        var tempTitle = movieDetails.title

        if let releaseDate = movieDetails.releaseDate {
            let year = String(releaseDate.prefix(4))
            tempTitle += " (\(year))"
        }

        self.title = tempTitle

        var originalTitleDurationText: [String] = []

        if movieDetails.originalTitle != movieDetails.title {
            originalTitleDurationText.append("Original title: \(movieDetails.originalTitle)")
        }

        let runtime = Double(movieDetails.runtime!) * 60

        if runtime > 0 {
            let formated = runtime.format(using: [.hour, .minute, .second])!
            originalTitleDurationText.append(formated)
        }

        self.subtitle = originalTitleDurationText.joined(separator: " | ")

        self.rating = String(format: "%.1f", movieDetails.voteAverage / 2)
    }
}

struct MovieDetailsTrailerSection: MovieDetailsSection {
    let type = MovieDetailsViewModelSectionsTypes.trailer

    let sectionHeadline: String = "Trailer"
    let imageUrl: URL!
    let videoUrl: URL!

    init?(with movieDetails: MovieDetails) {
        let youtubeBaseImageUrl = "https://i3.ytimg.com/vi/{VIDEO_KEY}/hqdefault.jpg"
        let youtubeBaseVideoUrl = "https://www.youtube.com/watch?v={VIDEO_KEY}"

        let video = movieDetails.videos?
            .first(where: {
                $0.site.lowercased() == "youtube" && $0.type == VideoType.trailer
            })

        guard
            let videoKey = video?.key,
            let imageUrl = URL(string: youtubeBaseImageUrl.replacingOccurrences(of: "{VIDEO_KEY}", with: videoKey)),
            let videoUrl = URL(string: youtubeBaseVideoUrl.replacingOccurrences(of: "{VIDEO_KEY}", with: videoKey)) else {
                return nil
        }

        self.videoUrl = videoUrl
        self.imageUrl = imageUrl
    }
}

struct MovieDetailsHeaderPerson {
    let id: Int
    let name: String
    let jobs: String

    init(id: Int, name: String, jobs: String) {
        self.id = id
        self.name = name
        self.jobs = jobs
    }
}

struct MovieDetailsHeaderSection: MovieDetailsSection {
    let type = MovieDetailsViewModelSectionsTypes.header

    let tagline: String?
    let posterUrl: URL?
    let genres: String!
    var director: MovieDetailsHeaderPerson?
    var screenplayer: MovieDetailsHeaderPerson?

    init?(with movieDetails: MovieDetails) {
        if let posterPath = movieDetails.posterPath {
            posterUrl = URL(string: Constants.api.imageBaseUrl)?
                .appendingPathComponent("w500")
                .appendingPathComponent(posterPath)
        } else {
            posterUrl = nil
        }

        genres = movieDetails.genres
            .map({ $0.name })
            .joined(separator: ", ")

        self.tagline = movieDetails.tagline!.isEmpty ? movieDetails.overview : movieDetails.tagline

        director = setupGroupedHeader(
            "Director",
            with: movieDetails.crew
        )

        screenplayer = setupGroupedHeader(
            "Screenplay",
            with: movieDetails.crew,
            personException: director?.id
        )
    }

    fileprivate func setupGroupedHeader(_ job: String, with crew: [Crew]?, personException: Int? = 0) -> MovieDetailsHeaderPerson? {
        guard let crew = crew else { return nil }

        if let person = crew.first(where: { $0.job == job && personException != $0.id }) {
            let jobs = crew
                .filter({ $0.id == person.id })
                .map({ $0.job })
                .sorted()
                .joined(separator: ", ")

            return MovieDetailsHeaderPerson(
                id: person.id,
                name: person.name,
                jobs: jobs
            )
        }
        return nil
    }
}

struct MovieDetailsViewModel {
    let details: MovieDetails?
    var sections: [MovieDetailsSection] = []
    var header: MovieDetailsHeaderSection!
    var posterUrl: URL?
    var favorited: Bool = false

    init(state: RootState) {
        details = state.movie.currentMovieDetails

        sections = []

        guard let details = details else { return }
        favorited = details.favorited == nil ? false : details.favorited!

        header = MovieDetailsHeaderSection(with: details)

        if let posterPath = details.posterPath {
            self.posterUrl = URL(string: Constants.api.imageBaseUrl)?
                .appendingPathComponent("w500")
                .appendingPathComponent(posterPath)
        }

        if let title = MovieDetailTitleSection(with: details) {
            sections.append(title)
        }

        if let summary = MovieDetailsSummarySection(with: details) {
            sections.append(summary)
        }

        if let trailer = MovieDetailsTrailerSection(with: details) {
            sections.append(trailer)
        }

    }
}

extension MovieDetailsViewModel: Equatable {
    static func == (lhs: MovieDetailsViewModel, rhs: MovieDetailsViewModel) -> Bool {
        return lhs.details == rhs.details
    }
}
