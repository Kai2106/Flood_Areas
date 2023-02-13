//
//  AppAPI.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import Moya
import Alamofire

enum APIErrorType: Int {
    case noConnection = -512
    case unknown = -2
    case invalidData = -1
    case error = 0
}

struct APIError: Error {
    public let type: APIErrorType
    public let description: String
}

enum APIResult<T> {
    case ok(data : T)
    case error(error : APIError)
    
    func result() -> T? {
        switch self {
        case .ok(data: let apiResult):
            return apiResult
        default:
            return nil
        }
    }
    
    func error() -> APIError? {
        switch self {
        case .error(error: let error):
            return error
        default:
            return nil
        }
    }
}

enum AppAPI {
    case getFloodAreas
}

extension AppAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.livetraffic.com/traffic/hazards")!
    }
    
    var path: String {
        switch self {
        case .getFloodAreas:
            return "/flood.json"
        }
    }
    
    public var url : String {
        return "\(baseURL)\(path)"
    }
    
    var method: Moya.Method {
        switch self {
            // Can add more cases here
        default:
            return Moya.Method.get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let defaultHeaders = ["Content-Type":"application/json"]
        
        return defaultHeaders
    }
}

// MARK: Cache Policy Gettable Type
extension AppAPI: CachePolicyGettableType {
    var cachePolicy: URLRequest.CachePolicy? {
        switch self {
        case .getFloodAreas:
            // don't cache data from request.
            return .reloadIgnoringLocalAndRemoteCacheData
        default:
            return .useProtocolCachePolicy
        }
    }
}


