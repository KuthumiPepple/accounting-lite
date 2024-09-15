DB_URL=postgresql://root:secret@localhost:5432/accountingdb?sslmode=disable

postgres:
	docker compose up

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

new_migration:
	migrate create -ext sql -dir db/migration -seq $(name)

.PHONY: postgres migrateup migratedown new_migration