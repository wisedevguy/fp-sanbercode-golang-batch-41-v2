package main

import (
	"database/sql"
	"fmt"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
	"github.com/wisedevguy/fp-sanbercode-golang-batch-41-v2/database"
	"github.com/wisedevguy/fp-sanbercode-golang-batch-41-v2/routers"
)

var (
	DB  *sql.DB
	err error
)

func main() {
	//err = godotenv.Load("config/local.env")
	err = godotenv.Load("config/deploy.env")
	if err != nil {
		fmt.Println("FAILED load file environment")
	} else {
		fmt.Println("SUCCESS read file environment")
	}

	//psqlInfo := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable", os.Getenv("DB_HOST"), os.Getenv("DB_PORT"), os.Getenv("DB_USER"), os.Getenv("DB_PASSWORD"), os.Getenv("DB_NAME"))
	psqlInfo := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable", os.Getenv("PGHOST"), os.Getenv("PGPORT"), os.Getenv("PGUSER"), os.Getenv("PGPASSWORD"), os.Getenv("PGDATABASE"))

	DB, err = sql.Open("postgres", psqlInfo)
	err = DB.Ping()
	if err != nil {
		fmt.Println("DB connection FAILED")
		panic(err)
	} else {
		fmt.Println("DB connection SUCCESS")
	}

	database.DbMigrate(DB)

	defer DB.Close()

	//routers.StartServer().Run(":8080")
	routers.StartServer().Run(":" + os.Getenv("PORT"))

}
