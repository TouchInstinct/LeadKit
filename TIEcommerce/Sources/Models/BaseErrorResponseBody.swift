import Foundation

struct BaseErrorResponseBody: Decodable, Equatable, Hashable {
    ///Код ошибки
    let errorCode: Int
    ///Текст сообщения об ошибке
    let errorMessage: String
}
