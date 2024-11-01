# Golangイメージを使用してビルド
FROM golang:1.23.2 AS builder

# 作業ディレクトリを設定
WORKDIR /app

# go.mod と go.sum を最初にコピーして依存関係をダウンロード
COPY go.mod ./
RUN go mod download

# 残りのコードとディレクトリをコンテナにコピー
COPY . .

# CGO無効化して静的バイナリをビルド
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o myapp

# 実行環境のための軽量イメージを使用
FROM gcr.io/distroless/static

# 必要なファイルをコピー
COPY --from=builder /app/myapp /myapp

# サーバーがリッスンするポートを指定
EXPOSE 8080

# アプリケーションの実行
CMD ["/myapp"]
