//
//  Абстрактный парсер ошибок
//

import Foundation

protocol ​AbstractErrorParser​ {
    /**
     Приводит ошибку к требуемому формату
     */
    func parse(_ result: Error) -> Error
    
    /**
     Приводит сетевую ошибку к требуемому формату
     
     - Parameters:
        - response: Ответ от сервера (ошибки HTTP)
        - data: Данные от сервера (в том случае если ошибки HTTP не было, но сервер вернул ошибку, в этом случае парсим ее)
     */
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
