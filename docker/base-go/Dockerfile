FROM golang:1.26-alpine

# ----------------------------------------------------------------------
# 1. Системные утилиты, часто используемые в процессе разработки
# ----------------------------------------------------------------------
RUN apk add --no-cache \
    git \
    make \
    bash \
    curl \
    && rm -rf /var/cache/apk/*

# Создаём пользователя с UID 1000 (замените на свой, если нужно)
RUN addgroup -g 1000 appgroup && adduser -u 1000 -G appgroup -D appuser

# ----------------------------------------------------------------------
# 2. Основные инструменты для Go-разработки
# ----------------------------------------------------------------------
RUN go install github.com/air-verse/air@latest
#    go install github.com/go-delve/delve/cmd/dlv@latest && \
#    go install golang.org/x/tools/cmd/goimports@latest && \
#    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest && \
#    go install github.com/securego/gosec/v2/cmd/gosec@latest && \
#    go install honnef.co/go/tools/cmd/staticcheck@latest && \
#    go install github.com/cweill/gotests/gotests@latest && \
#    go install go.uber.org/mock/mockgen@latest && \
#    go install github.com/swaggo/swag/cmd/swag@latest && \
#    go install github.com/magefile/mage@latest && \
#    go install github.com/goreleaser/goreleaser@latest

# ----------------------------------------------------------------------
# 3. Дополнительные инструменты для работы с gRPC / protobuf (опционально)
# ----------------------------------------------------------------------
# RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
#     go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Даём пользователю права на запись в /go/pkg (кеш модулей)
RUN mkdir -p /go/pkg && chown -R 1000:1000 /go/pkg

# ----------------------------------------------------------------------
# 4. Создаём рабочую директорию и добавляем Go-бинарники в PATH
# ----------------------------------------------------------------------
WORKDIR /app
ENV PATH=$PATH:/go/bin

# Проверка установки (можно заменить на любой другой инструмент)
CMD ["go", "version"]