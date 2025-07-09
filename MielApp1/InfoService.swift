
//
//  InfoService.swift
//  MielApp1
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

final class InfoService {

    /// Возвращает «сырые» данные из `/api/info/`.
    /// Декодирование в нужную модель делай в слое View-Model / Store.
    func fetch(completion: @escaping (Result<Any, Error>) -> Void) {

        ApiAPI.apiInfoRetrieve { data, error in
            if let error {
                completion(.failure(error))
            } else if let value = data?.value {          // value может быть словарём или массивом
                completion(.success(value))
            } else {
                let err = NSError(
                    domain: "InfoService",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey : "Ответ пустой"]
                )
                completion(.failure(err))
            }
        }
    }
}
