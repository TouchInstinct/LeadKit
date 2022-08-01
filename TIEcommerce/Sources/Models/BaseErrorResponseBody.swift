import Foundation

protocol BaseErrorResponseBody: Decodable, Hashable {
    ///Код ошибки
    var errorCode: Int { get }
    ///Текст сообщения об ошибке
    var errorMessage: String { get }
}
