# DateFormatting

Date to string and wise versa formatting using DateFormatters reuse pool

## Codable model example

Date format enum:

```swift
enum APIDateFormat: String, DateFormat {
    case yyyyMMddTHHmmssSZ = "yyyy-MM-dd'T'HH:mm:ss.SZ"
}
```

Codable model:

```swift
struct Token: Codable {

    private enum CodingKeys: String, CodingKey {
        case name
        case value
        case expirationDate = "expiration"
    }

    var name: String
    var value: String
    var expirationDate: Date

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        value = try container.decode(String.self, forKey: .value)

        let dateFormatter = try decoder.userInfo.dateFormatter(for: APIDateFormat.yyyyMMddTHHmmssSZ)

        expirationDate = try container.decodeDate(forKey: .expirationDate,
                                                  using: dateFormatter)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(value, forKey: .value)

        let dateFormatter = try encoder.userInfo.dateFormatter(for: APIDateFormat.yyyyMMddTHHmmssSZ)

        try container.encode(date: expirationDate,
                             forKey: .expirationDate,
                             using: dateFormatter)
    }
}
```

JSON Decoding example:

```swift
let reusePool = DateFormattersReusePool()

let decoder = JSONDecoder()
decoder.userInfo[.dateFormattersReusePool!] = reusePool

let tokenJSON = """
  {
    "name": "access",
    "value": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjoibW9jayIsImlhdCI6MTYyNTU4NTU0MSwiZXhwIjoxNjI1NTg5MTQxfQ.zkdLwh6M7IPcTA8PY5gsfUzR-UTGzpWUtYqZur3RxqA",
    "expiration": "2021-07-06T16:32:21.211Z"
  }
"""

let token = try decoder.decode(Token.self, from: tokenJSON.data(using: .utf8)!)
```

## UI date formatting example

```swift
enum ProjectDateFormat: String, DateFormat {

    case defaultDate = "MM/dd/yyyy"

    case yyyyMMdd = "yyyy-MM-dd"

    case MMMM = "MMMM"

    case dMMM = "d MMM"

    func configure(dateFormatter: DateFormatter) {
        dateFormatter.dateFormat = rawValue

        switch self {
        case .dMMM:
            dateFormatter.dateStyle = .medium
        default:
            break
        }
    }
}

let dateFormattingService = DateFormattingService(reusePool: reusePool)

let formattedDate = dateFormattingService.string(from: Date(), using: ProjectDateFormat.dMMM)
```
