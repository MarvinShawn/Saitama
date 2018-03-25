//  This file was automatically generated and should not be edited.

import Apollo

public final class ItemsQuery: GraphQLQuery {
  public static let operationString =
    "query Items($page: Int!, $pageNum: Int!, $type: Int!) {\n  items(page: $page, pageNum: $pageNum, type: $type) {\n    __typename\n    pageItems\n    totalPages\n    currentPage\n    rows {\n      __typename\n      ...Qiushi\n    }\n  }\n}"

  public static var requestString: String { return operationString.appending(Qiushi.fragmentString) }

  public var page: Int
  public var pageNum: Int
  public var type: Int

  public init(page: Int, pageNum: Int, type: Int) {
    self.page = page
    self.pageNum = pageNum
    self.type = type
  }

  public var variables: GraphQLMap? {
    return ["page": page, "pageNum": pageNum, "type": type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("items", arguments: ["page": GraphQLVariable("page"), "pageNum": GraphQLVariable("pageNum"), "type": GraphQLVariable("type")], type: .object(Item.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(items: Item? = nil) {
      self.init(snapshot: ["__typename": "Query", "items": items.flatMap { $0.snapshot }])
    }

    public var items: Item? {
      get {
        return (snapshot["items"] as? Snapshot).flatMap { Item(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "items")
      }
    }

    public struct Item: GraphQLSelectionSet {
      public static let possibleTypes = ["pageInfo"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("pageItems", type: .scalar(Int.self)),
        GraphQLField("totalPages", type: .scalar(Int.self)),
        GraphQLField("currentPage", type: .scalar(Int.self)),
        GraphQLField("rows", type: .list(.object(Row.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(pageItems: Int? = nil, totalPages: Int? = nil, currentPage: Int? = nil, rows: [Row?]? = nil) {
        self.init(snapshot: ["__typename": "pageInfo", "pageItems": pageItems, "totalPages": totalPages, "currentPage": currentPage, "rows": rows.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// items per page
      public var pageItems: Int? {
        get {
          return snapshot["pageItems"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "pageItems")
        }
      }

      /// total pages
      public var totalPages: Int? {
        get {
          return snapshot["totalPages"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "totalPages")
        }
      }

      /// current page
      public var currentPage: Int? {
        get {
          return snapshot["currentPage"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "currentPage")
        }
      }

      /// items array
      public var rows: [Row?]? {
        get {
          return (snapshot["rows"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Row(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "rows")
        }
      }

      public struct Row: GraphQLSelectionSet {
        public static let possibleTypes = ["QiushiItem"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("comments", type: .scalar(Int.self)),
          GraphQLField("likes", type: .scalar(Int.self)),
          GraphQLField("contentText", type: .scalar(String.self)),
          GraphQLField("nickname", type: .scalar(String.self)),
          GraphQLField("avatar", type: .scalar(String.self)),
          GraphQLField("age", type: .scalar(Int.self)),
          GraphQLField("gender", type: .scalar(Bool.self)),
          GraphQLField("contentImg", type: .scalar(String.self)),
          GraphQLField("ratio", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(comments: Int? = nil, likes: Int? = nil, contentText: String? = nil, nickname: String? = nil, avatar: String? = nil, age: Int? = nil, gender: Bool? = nil, contentImg: String? = nil, ratio: Double? = nil) {
          self.init(snapshot: ["__typename": "QiushiItem", "comments": comments, "likes": likes, "contentText": contentText, "nickname": nickname, "avatar": avatar, "age": age, "gender": gender, "contentImg": contentImg, "ratio": ratio])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var comments: Int? {
          get {
            return snapshot["comments"] as? Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "comments")
          }
        }

        public var likes: Int? {
          get {
            return snapshot["likes"] as? Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "likes")
          }
        }

        public var contentText: String? {
          get {
            return snapshot["contentText"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "contentText")
          }
        }

        public var nickname: String? {
          get {
            return snapshot["nickname"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "nickname")
          }
        }

        public var avatar: String? {
          get {
            return snapshot["avatar"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "avatar")
          }
        }

        public var age: Int? {
          get {
            return snapshot["age"] as? Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "age")
          }
        }

        public var gender: Bool? {
          get {
            return snapshot["gender"] as? Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "gender")
          }
        }

        public var contentImg: String? {
          get {
            return snapshot["contentImg"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "contentImg")
          }
        }

        public var ratio: Double? {
          get {
            return snapshot["ratio"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "ratio")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        public struct Fragments {
          public var snapshot: Snapshot

          public var qiushi: Qiushi {
            get {
              return Qiushi(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

public struct Qiushi: GraphQLFragment {
  public static let fragmentString =
    "fragment Qiushi on QiushiItem {\n  __typename\n  comments\n  likes\n  contentText\n  nickname\n  avatar\n  age\n  gender\n  contentImg\n  ratio\n}"

  public static let possibleTypes = ["QiushiItem"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("comments", type: .scalar(Int.self)),
    GraphQLField("likes", type: .scalar(Int.self)),
    GraphQLField("contentText", type: .scalar(String.self)),
    GraphQLField("nickname", type: .scalar(String.self)),
    GraphQLField("avatar", type: .scalar(String.self)),
    GraphQLField("age", type: .scalar(Int.self)),
    GraphQLField("gender", type: .scalar(Bool.self)),
    GraphQLField("contentImg", type: .scalar(String.self)),
    GraphQLField("ratio", type: .scalar(Double.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(comments: Int? = nil, likes: Int? = nil, contentText: String? = nil, nickname: String? = nil, avatar: String? = nil, age: Int? = nil, gender: Bool? = nil, contentImg: String? = nil, ratio: Double? = nil) {
    self.init(snapshot: ["__typename": "QiushiItem", "comments": comments, "likes": likes, "contentText": contentText, "nickname": nickname, "avatar": avatar, "age": age, "gender": gender, "contentImg": contentImg, "ratio": ratio])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var comments: Int? {
    get {
      return snapshot["comments"] as? Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "comments")
    }
  }

  public var likes: Int? {
    get {
      return snapshot["likes"] as? Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "likes")
    }
  }

  public var contentText: String? {
    get {
      return snapshot["contentText"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "contentText")
    }
  }

  public var nickname: String? {
    get {
      return snapshot["nickname"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "nickname")
    }
  }

  public var avatar: String? {
    get {
      return snapshot["avatar"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "avatar")
    }
  }

  public var age: Int? {
    get {
      return snapshot["age"] as? Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "age")
    }
  }

  public var gender: Bool? {
    get {
      return snapshot["gender"] as? Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "gender")
    }
  }

  public var contentImg: String? {
    get {
      return snapshot["contentImg"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "contentImg")
    }
  }

  public var ratio: Double? {
    get {
      return snapshot["ratio"] as? Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "ratio")
    }
  }
}