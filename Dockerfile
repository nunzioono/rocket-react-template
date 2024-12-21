FROM rust:bullseye AS backend-builder
WORKDIR /app
COPY ./backend .
RUN cargo install --path .

FROM node:bullseye-slim AS frontend-builder
WORKDIR /app
COPY ./frontend .
RUN npm install && npm run build

FROM debian:bullseye-slim
WORKDIR /app
COPY --from=backend-builder /usr/local/cargo/bin/backend /app/backend
COPY --from=frontend-builder /app/dist /app/static
EXPOSE 8000
CMD ["/app/backend"]