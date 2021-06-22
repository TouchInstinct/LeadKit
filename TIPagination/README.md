# TIPagination

Компонент “Пагинация” предоставляет реализацию:
* Пагинации элементов из источника данных (API, DB, etc.)
* Обработки состояний в ходе получения данных (загрузка, ошибка, подгрузка, ошибка подгрузки, etc.)
* Делегирование отображения состояний внешнему коду

## Пример реализации

### Создание источника данных
Источником данных служит абстрактный `Cursor`. Он может как выполнять запросы к серверу на получение новых элементов, так и получать данные из локального хранилища. 

Например, существует API, который возвращает постраничный список банков, в которых у пользователя есть счёт. Также в каждом ответе указывается банк пользователя по умолчанию, в который должны приходить платежи. 

```swift
/// Модель одного банка
struct Bank: Codable {
    let name: String
    let primaryColor: UIColor
}

/// Модель страницы банков, приходящая с сервера
struct BanksPage: PageType, Codable {

    let pagesRemaining: Int // Количество оставшихся страниц

    let pageItems: [Bank]
    let defaultBank: Bank? // Банк по умолчанию. Может изменяться при получении новых страниц.

    init(items: [Bank], defaultBank: Bank?, pagesRemaining: Int) {
        self.pageItems = items
        self.defaultBank = defaultBank
        self.pagesRemaining = pagesRemaining
    }

    init(copy ancestor: Self, pageItems: [Bank]) {
        self.pagesRemaining = ancestor.pagesRemaining
        self.pageItems = pageItems
        self.defaultBank = ancestor.defaultBank
    }
}
```

После создания модели данных необходимо создать курсор, который будет отвечать за загрузку данных с сервера. Для этого удобно использовать Combine:

```swift
import Combine

...

final class BankListCursor: PaginatorCursorType {

    enum BankListCursorError: CursorErrorType {

        case exhausted
        case url

        public var isExhausted: Bool {
            self == .exhausted
        }

        public static var exhaustedError: BankListCursorError {
            .exhausted
        }
    }

    typealias Page = BanksPage
    typealias Failure = BankListCursorError

    // MARK: - Private Properties

    let urlSession = URLSession(configuration: .default)

    private var page: Int
    private var requestCancellable: AnyCancellable?

    // MARK: - Public Initializers

    init() {
        page = 1
    }

    init(withInitialStateFrom other: BankListCursor) {
        page = 1
    }

    // MARK: - Public Methods

    func cancel() {
        requestCancellable?.cancel()
    }

    func loadNextPage(completion: @escaping ResultCompletion) {

        guard let publisher = publisherForPage(page) else {
            completion(.failure(.url))
            return
        }

        requestCancellable = publisher
            .catch { _ in
                Just(nil)
            }
            .sink { [weak self] result in

                guard result != nil else {
                    completion(.failure(.network))
                    return
                }

                self?.page += 1

                completion(.success( (page: result, exhausted: result.pagesRemaining < 1) ))
            }
    }

    // MARK: - Private Methods

    private func publisherForPage(_ page: Int) -> AnyPublisher<Data?, URLError>? {

        guard let url = URL(string: "https://some-bank-api.com/user_banks?page=\(page)") else {
            return nil
        }

        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: BanksPage.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
```

### Поддержка делегата данных

`PaginatorDelegate` представляет из себя протокол, который сигнализирует об изменении состоянии данных в источнике. Пример реализации с использованием TableKit и TableDirector:

```swift
extension MyViewController: PaginatorDelegate {
    
    func paginator(didLoad newPage: MockCursor.Page) {
        updateDefaultBank(with: newPage.defaultBank) // Обновление банка, установленного у пользователя по умолчанию
    
        let rows = newPage.pageItems.map { /* Create table cell rows */ }
        tableDirector.append(section: .init(onlyRows: rows)).reload()
    }

    func paginator(didReloadWith page: MockCursor.Page) {
        updateDefaultBank(with: newPage.defaultBank) // Обновление банка, установленного у пользователя по умолчанию
        
        let rows = page.pageItems.map { /* Create table cell rows */ }
        tableDirector.clear().append(section: .init(onlyRows: rows)).reload()
    }

    func clearContent() {
        tableDirector.clear().reload()
    }
}
```

### Поддержка UI-делегатов

`PaginatorUIDelegate` используется для управления UI. Он содержит набор методов, которые вызываются после перехода модели данных в то или иное состояние. В них можно показать ActivityIndicator, плейсхолдер для ошибки или для пустого состояния. Большинство работы берет на себя стандартная реализация этого протокола – `DefaultPaginatorUIDelegate`. Работать с ней очень просто:

```swift
...
private lazy var paginatorUiDelegate = DefaultPaginatorUIDelegate<MockCursor>(tableView)
...
```

Вторым UI-делегатом является `InfiniteScrollDelegate`, который необходим для поддержания совместимости с фреймворком **UIScrollView_InfiniteScroll**. Делегат обязан выполнять проксирование методов в UIScrollView, который используется для пагинации. В качестве делегата можно также использовать UITableView из коробки:

```swift
import UIScrollView_InfiniteScroll

...

extension UITableView: InfiniteScrollDelegate {}
```

### Создание Paginator

После того, как источник данных и все делегаты установлены, можно приступать к созданию объекта `Paginator`. Этот объект является ответственным за управление состоянием пагинации извне (загрузка, перезагрузка, повтор загрузки данных после ошибок). Для его создания потребуются все ранее определенные составляющие:

```swift
...
private lazy var paginator = Paginator(cursor: mockCursor,
                                       delegate: self,
                                       infiniteScrollDelegate: tableView,
                                       uiDelegate: paginatorUiDelegate)
...

override func viewDidLoad() {
    super.viewDidLoad()
    
    // Callback у DefaultPaginatorUIDelegate, срабатывает при нажатии на кнопку "Retry Loading"
    paginatorUiDelegate.onRetry = { [weak self] in
        self?.paginator.retry() 
    }

    paginator.reload() // Первоначальная загрузка данных
}

```
