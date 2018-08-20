//
//  Функциональные паттерны
//

enum Result<T> {
    case error(String)
    case success(T)
}
