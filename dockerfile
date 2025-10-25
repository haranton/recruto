# Этап 1: сборка бинарника
FROM golang:1.25-alpine AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum, чтобы заранее установить зависимости
COPY go.mod go.sum ./
RUN go mod download

# Копируем исходники
COPY . .

# Собираем бинарник (маленький, статически слинкованный)
RUN go build -o main .

# Этап 2: финальный образ
FROM alpine:latest

WORKDIR /app

# Копируем бинарник из builder
COPY --from=builder /app/main .

# Открываем порт
EXPOSE 8080

# Запуск
CMD ["./main"]