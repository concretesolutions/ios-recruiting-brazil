//
//  Seeds.swift
//  MovsTests
//
//  Created by Tiago Chaves on 18/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

@testable import Movs
import Foundation

struct Seeds{
	
	struct MovieViewmodelList {
		
		static let movie1 = MovieViewModel(id: 1,
									title: "The Predator",
									posterUrl: "/wMq9kQXTeQCHUZOG4fAe5cAxyUA.jpg",
									favoriteStatus: false)
		
		static let movie2 = MovieViewModel(id: 2,
										   title: "A Star Is Born",
										   posterUrl: "/wrFpXMNBRj2PBiN4Z5kix51XaIZ.jpg",
										   favoriteStatus: false)
		
		static let movie3 = MovieViewModel(id: 3,
										   title: "Hotel Transylvania 3: Summer Vacation",
										   posterUrl: "/gjAFM4xhA5vyLxxKMz38ujlUfDL.jpg",
										   favoriteStatus: false)
		
		static let movie4 = MovieViewModel(id: 4,
										   title: "Sicario: Day of the Soldado",
										   posterUrl: "/msqWSQkU403cQKjQHnWLnugv7EY.jpg",
										   favoriteStatus: false)
		
		static let movie5 = MovieViewModel(id: 5,
										   title: "Johnny English Strikes Again",
										   posterUrl: "/msqWSQkU403cQKjQHnWLnugv7EY.jpg",
										   favoriteStatus: false)
		
		static let movie6 = MovieViewModel(id: 6,
										   title: "Smallfoot",
										   posterUrl: "/4nKoB6wMVXfsYgRZK5lHZ5VMQ6J.jpg",
										   favoriteStatus: false)
		
		static let movie7 = MovieViewModel(id: 7,
									title: "Bad Times at the El Royale",
									posterUrl: "/iNtFgXqXPRMkm1QO8CHn5sHfUgE.jpg",
									favoriteStatus: false)
		
		static let movieList = [movie1,
								movie2,
								movie3,
								movie4,
								movie5,
								movie6,
								movie7]
	}
	
	struct PopularMovieResultAPI {
		
		static let movie1  = Movie(title: "The Predator",
								   poster: "/wMq9kQXTeQCHUZOG4fAe5cAxyUA.jpg",
								   backdrop: "/f4E0ocYeToEuXvczZv6QArrMDJ.jpg",
								   date: Date(),
								   genre_ids: [27,
											   878,
											   28,
											   35],
								   overview: "From the outer reaches of space to the small-town streets of suburbia, the hunt comes home. Now, the universe’s most lethal hunters are stronger, smarter and deadlier than ever before, having genetically upgraded themselves with DNA from other species. When a young boy accidentally triggers their return to Earth, only a ragtag crew of ex-soldiers and a disgruntled science teacher can prevent the end of the human race.",
								   id: 1)
		
		static let movie2   = Movie(title: "A Star Is Born",
									poster: "/wrFpXMNBRj2PBiN4Z5kix51XaIZ.jpg",
									backdrop: "/840rbblaLc4SVxm8gF3DNdJ0YAE.jpg",
									date: Date(),
									genre_ids: [18,
												10402,
												10749],
									overview: "Seasoned musician Jackson Maine discovers—and falls in love with—struggling artist Ally. She has just about given up on her dream to make it big as a singer—until Jack coaxes her into the spotlight. But even as Ally's career takes off, the personal side of their relationship is breaking down, as Jack fights an ongoing battle with his own internal demons.",
									id: 2)
		
		static let movie3  = Movie(title: "A Star Is Born",
								   poster: "/gjAFM4xhA5vyLxxKMz38ujlUfDL.jpg",
								   backdrop: "/m03jul0YdVEOFXEQVUv6pOVQYGL.jpg",
								   date: Date(),
								   genre_ids: [10751,
											   14,
											   35,
											   16],
								   overview: "Dracula, Mavis, Johnny and the rest of the Drac Pack take a vacation on a luxury Monster Cruise Ship, where Dracula falls in love with the ship’s captain, Ericka, who’s secretly a descendant of Abraham Van Helsing, the notorious monster slayer.",
								   id: 3)
		
		static let movie4  = Movie(title: "Sicario: Day of the Soldado",
								   poster: "/msqWSQkU403cQKjQHnWLnugv7EY.jpg",
								   backdrop: "/tnwMCH4yLBY4qpe6Nr4n66u4U3f.jpg",
								   date: Date(),
								   genre_ids: [28,
											   80,
											   18,
											   53],
								   overview: "Agent Matt Graver teams up with operative Alejandro Gillick to prevent Mexican drug cartels from smuggling terrorists across the United States border.",
								   id: 4)
		
		static let movie5  = Movie(title: "Johnny English Strikes Again",
								   poster: "/msqWSQkU403cQKjQHnWLnugv7EY.jpg",
								   backdrop: "/tnwMCH4yLBY4qpe6Nr4n66u4U3f.jpg",
								   date: Date(),
								   genre_ids: [12,
											   10751,
											   28,
											   35],
								   overview: "Disaster strikes when a criminal mastermind reveals the identities of all active undercover agents in Britain. The secret service can now rely on only one man—Johnny English. Currently teaching at a minor prep school, Johnny springs back into action to find the mysterious hacker. For this mission to succeed, he’ll need all of his skills—what few he has—as the man with yesterday’s analogue methods faces off against tomorrow’s digital technology.",
								   id: 5)
		
		static let movie6  = Movie(title: "Smallfoot",
								   poster: "/4nKoB6wMVXfsYgRZK5lHZ5VMQ6J.jpg",
								   backdrop: "/7t88SoT3Dd8DhGnQuVoSbMNUl3W.jpg",
								   date: Date(),
								   genre_ids: [35,
											   16,
											   10751,
											   12,
											   14],
								   overview: "A bright young yeti finds something he thought didn't exist—a human. News of this “smallfoot” throws the simple yeti community into an uproar over what else might be out there in the big world beyond their snowy village.",
								   id: 6)
		
		static let movie7  = Movie(title: "Bad Times at the El Royale",
								   poster: "/iNtFgXqXPRMkm1QO8CHn5sHfUgE.jpg",
								   backdrop: "/gb3TVVZNNxVGNfS1NxGaiWZfwnW.jpg",
								   date: Date(),
								   genre_ids: [53,
											   27,
											   80],
								   overview: "Seven strangers, each with a secret to bury, meet at Lake Tahoe's El Royale, a rundown hotel with a dark past in 1969. Over the course of one fateful night, everyone will have a last shot at redemption.",
								   id: 6)
		
		static let movieList = [movie1,
								movie2,
								movie3,
								movie4,
								movie5,
								movie6,
								movie7]
		
		static let result = PopularMoviesResult(page: 1, total_pages: 999, results: movieList)
	}
}
