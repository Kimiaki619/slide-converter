# クリーンアーキテクチャ入門

---

## アジェンダ

- クリーンアーキテクチャとは何か
- 4つの層
- 依存関係のルール
- DI の仕組み
- リクエストの流れ

---

## クリーンアーキテクチャとは

MVC の課題を解決するために Robert C. Martin（Uncle Bob）が 2012 年に提唱。

- ビジネスロジックをフレームワーク・DB から独立させる
- 内側の層は外側の層を知らない
- DB なしでビジネスロジックをテストできる

---

## 4つの層

```mermaid
graph TD
    F["Frameworks & Drivers<br>Laravel / MySQL / Docker"]
    A["Interface Adapters<br>Controller / Repository実装"]
    U["Use Cases<br>ビジネスの処理フロー"]
    E["Entities<br>ビジネスルール（最内層）"]

    F --> A --> U --> E

    style F fill:#f4a460,stroke:#8b4513,color:#000
    style A fill:#87ceeb,stroke:#4682b4,color:#000
    style U fill:#90ee90,stroke:#228b22,color:#000
    style E fill:#dda0dd,stroke:#8b008b,color:#000
```

---

## 依存関係のルール

```mermaid
flowchart TD
    F["Frameworks & Drivers"]
    A["Interface Adapters"]
    U["Use Cases"]
    E["Entities"]

    F -->|依存OK| A
    A -->|依存OK| U
    U -->|依存OK| E
    E -. "外側への依存NG ❌" .-> U

    style F fill:#f4a460,stroke:#8b4513,color:#000
    style A fill:#87ceeb,stroke:#4682b4,color:#000
    style U fill:#90ee90,stroke:#228b22,color:#000
    style E fill:#dda0dd,stroke:#8b008b,color:#000
```

---

## 開発手順

**内側から外側へ**の順番で作るのが基本。

```mermaid
flowchart TD
    E["① Entity<br>ビジネスルールを定義する"]
    R["② Repository Interface<br>抽象だけ定義する"]
    U["③ Use Case<br>ビジネスの処理フロー<br>を書く"]
    RI["④ Repository実装<br>DBへの実際の<br>アクセスを書く"]
    C["⑤ Controller<br>HTTPリクエストを<br>UseCaseに渡す"]
    DI["⑥ DI登録<br>Interfaceと実装を紐づける"]

    E --> R --> U --> RI --> C --> DI

    style E fill:#dda0dd,stroke:#8b008b,color:#000
    style R fill:#dda0dd,stroke:#8b008b,color:#000
    style U fill:#90ee90,stroke:#228b22,color:#000
    style RI fill:#87ceeb,stroke:#4682b4,color:#000
    style C fill:#87ceeb,stroke:#4682b4,color:#000
    style DI fill:#f4a460,stroke:#8b4513,color:#000
```
---

## DI の仕組み

```mermaid
flowchart LR
    UC["UseCase"]
    I["RepositoryInterface<br>（抽象）"]
    Fake["FakeRepository<br>（開発初期）"]
    DB["EloquentRepository<br>（DB実装）"]
    SP["AppServiceProvider<br>bindで紐づける"]

    UC -->|依存| I
    I -->|実装| Fake
    I -->|実装| DB
    SP -->|切り替える| I

    style UC fill:#dda0dd,stroke:#8b008b,color:#000
    style I fill:#90ee90,stroke:#228b22,color:#000
    style Fake fill:#87ceeb,stroke:#4682b4,color:#000
    style DB fill:#87ceeb,stroke:#4682b4,color:#000
    style SP fill:#f4a460,stroke:#8b4513,color:#000
```

---

## リクエストの流れ

```mermaid
flowchart LR
    Req["HTTPリクエスト"]
    C["Controller<br>バリデーション"]
    UC["UseCase<br>処理フロー"]
    E["Entity<br>ビジネスルール"]
    R["Repository"]
    DB["MySQL"]
    Res["HTTPレスポンス"]

    Req --> C --> UC --> E --> UC --> R --> DB --> Res

    style E fill:#dda0dd,stroke:#8b008b,color:#000
    style UC fill:#90ee90,stroke:#228b22,color:#000
    style C fill:#87ceeb,stroke:#4682b4,color:#000
    style DB fill:#f4a460,stroke:#8b4513,color:#000
```

---

## まとめ

- **内側の層はフレームワーク・DBを知らない**
- **依存は必ず内側へ**
- **Repository を差し替えるだけで DB を変えられる**
- **DB なしでビジネスロジックをテストできる**
