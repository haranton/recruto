# Этап 1: сборка бинарника
FROM golang:1.25-alpine AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем модули и устанавливаем зависимости
COPY go.mod go.sum ./
RUN go mod download

# Копируем исходники
COPY . .

# Собираем бинарник (статически, без CGO, чтобы уменьшить размер и нагрузку)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# Этап 2: финальный минимальный образ
FROM alpine:latest

WORKDIR /app

# Копируем бинарник из builder
COPY --from=builder /app/main .

# Открываем порт
EXPOSE 8080

# По умолчанию запуск бинарника
ENTRYPOINT ["./main"]