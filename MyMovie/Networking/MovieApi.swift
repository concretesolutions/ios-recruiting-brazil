import Foundation
import Moya

enum MyMovie {
	
	case genres()
	case mostPopular(page:Int)
}

// MARK: - TargetType Protocol Implementation

extension MyMovie: TargetType {
	var baseURL: URL { return URL(string: "https://api.themoviedb.org/3")! }
	
	var path: String {
		switch self {
		case .genres:
			return "/genre/movie/list"
		case .mostPopular:
			return "/movie/popular"
		}
	}
	var method: Moya.Method {
		return .get
	}
	
	var task: Task {
		switch self {
		case .genres():
			return .requestParameters(parameters: defaultParams, encoding: URLEncoding.queryString )
		case .mostPopular(let page):
			var dictionary = defaultParams
			dictionary["page"] = page
			return .requestParameters(parameters: dictionary, encoding: URLEncoding.queryString )
		}
	}
	var sampleData: Data {
		return "{}".utf8Encoded
	}
	
	var defaultParams: [String: Any] {
		return ["api_key": "57d63585e93c42ae79a8609e1d5bc285"]
	}
	
	var headers: [String: String]? {
		return ["Content-type": "application/json"]
	}
}

private extension String {
	var urlEscaped: String {
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}
	
	var utf8Encoded: Data {
		return data(using: .utf8)!
	}
}
