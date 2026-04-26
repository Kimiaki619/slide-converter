#!/bin/bash
# 使い方:
#   ./convert.sh <input.md>                          # デフォルト（pptx）
#   ./convert.sh <input.md> <ファイル形式>            # 形式指定（pptx, docxなど）
#   ./convert.sh <input.md> <ファイル形式> <template> # 形式＋テンプレ指定

INPUT=$1
OUTPUT_FILE_TYPE=${2:-"pptx"}
TEMPLATE=${3:-"default.pptx"}

if [ -z "$INPUT" ]; then
  echo "使い方: ./convert.sh <input.md> [ファイル形式] [template.pptx]"
  echo "例:     ./convert.sh input/sample.md"
  echo "例:     ./convert.sh input/sample.md docx"
  echo "例:     ./convert.sh input/sample.md pptx custom.pptx"
  exit 1
fi

echo "このファイル形式で保存します: .$OUTPUT_FILE_TYPE"
OUTPUT="output/$(basename "$INPUT" .md).$OUTPUT_FILE_TYPE"

TEMPLATE_PATH="templates/$TEMPLATE"

if [ -f "$TEMPLATE_PATH" ]; then
  REFERENCE_OPT="--reference-doc=$TEMPLATE_PATH"
else
  echo "テンプレが見つからないためデフォルトスタイルで変換します: $TEMPLATE_PATH"
  REFERENCE_OPT=""
fi

docker compose -f docker/docker-compose.yml run --rm converter \
  pandoc "$INPUT" -o "$OUTPUT" --filter mermaid-filter $REFERENCE_OPT

echo "変換完了: $OUTPUT"
