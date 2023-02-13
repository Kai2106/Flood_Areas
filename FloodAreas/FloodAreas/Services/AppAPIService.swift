//
//  AppAPIService.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import RxCocoa
import RxSwift
import Moya
import Alamofire

final class AppAPIService {
    let provider = MoyaProvider<AppAPI>(plugins: [CachePolicyPlugin()])
    
    // MARK: Singleton
    static let shared = AppAPIService()
    
    static let unknownError = "unknown error occured"
    
    static let invalidDataError = "invalid data"
    
    static let noConnectionError = "no connection"
    
    static func prettyPrintJsonData(_ data: Data) {
        let stringData = String(data: data, encoding: .utf8) ?? ""
        
        AppLog.d(stringData)
    }
    
    // This is a generic wrapper function for API request. All API request must be called through this.
    func request<T: Codable>(_ api: AppAPI) -> Observable<APIResult<T>> {
        AppLog.s(api)
        return provider.rx.request(api).asObservable()
            // handle Response
            .flatMap({ response  -> Observable<APIResult<T>> in
                
                // show log
                AppLog.s(response.response ?? HTTPURLResponse())
                Self.prettyPrintJsonData(response.data)
                
                // decoder
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(T.self, from: response.data) {
                    return Observable.just(APIResult.ok(data: data))
                }
                
                // In error case.
                return Observable.just(APIResult.error(error: APIError(type: .invalidData, description: Self.invalidDataError)))
            })
            .catchError{ error in
                return Observable.just(APIResult.error(error: APIError(type: .noConnection, description: Self.noConnectionError)))
            }
    }
}

extension AppAPIService {
    func getFloodAreaData() -> Observable<APIResult<FloodArea>> {
        return request(.getFloodAreas)
    }
}
