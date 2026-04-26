# Slide Converter デモ

## 目的

Markdown で書いたスライド原稿を Docker + pandoc + mermaid-filter を使って PowerPoint に変換する仕組みを体感するためのデモ。

- Markdown でスライドを書く感覚をつかむ
- Mermaid でフロー図・シーケンス図を描く
- Docker 環境で pandoc を動かす構成を学ぶ
- テンプレートを差し替えてデザインを変える仕組みを体感する

## 技術スタック

- Markdown（スライド原稿）
- Mermaid（図の記述）
- pandoc（Markdown → PowerPoint 変換）
- mermaid-filter（Mermaid → PNG 変換）
- Docker

## 使用するファイル

```
takubo_doc/
├── convert.sh                      ← 変換スクリプト
├── docker/
│   ├── Dockerfile                  ← pandoc + mermaid-filter 環境
│   └── docker-compose.yml
├── input/
│   └── （変換したい .md を置く）
├── output/
│   └── （変換後の .pptx が生成される）
├── templates/
│   └── default.pptx                ← スタイルのテンプレート
└── tech/demo/slide-converter/
    ├── README.md                   ← このファイル
    └── sample.md                   ← サンプルスライド原稿
```

## 変換手順

```bash
# 1. sample.md を input/ にコピー
cp tech/demo/slide-converter/sample.md input/

# 2. 変換実行（takubo_doc/ から実行）
./convert.sh input/sample.md

# 3. output/sample.pptx が生成される
```

テンプレートを指定する場合：
```bash
./convert.sh input/sample.md pptx custom.pptx
```

## convert.sh の引数

| 引数 | 説明 | デフォルト |
|------|------|-----------|
| 第1引数 | 変換する Markdown ファイル | 必須 |
| 第2引数 | 出力形式 | pptx |
| 第3引数 | テンプレートファイル名 | default.pptx |

## Markdown → スライドの対応

| Markdown | スライド上の意味 |
|----------|----------------|
| `# タイトル` | スライドのタイトル |
| `## 見出し` | 新しいスライドの開始 |
| 箇条書き `-` | 箇条書きテキスト |
| `\`\`\`mermaid` | 図（PNG に変換される） |
| `---` | スライドの区切り |
