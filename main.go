package main

import (
	"log"
	"os"
	"time"

	"github.com/go-sql-driver/mysql"
	"github.com/jimmysawczuk/try"
	"github.com/jmoiron/sqlx"
	"github.com/pkg/errors"
)

type silentLogger struct{}

func (silentLogger) Print(v ...interface{}) {
	// do nothing
}

func init() {
	mysql.SetLogger(silentLogger{})
}

var timeout = 60 * time.Second
var interval = 1 * time.Second

func main() {
	if len(os.Args) < 2 {
		log.Fatalf("missing required argument: database connection string")
		os.Exit(1)
	}

	connectionString := os.Args[1]
	start := time.Now()

	log.Printf("attempting to connect to mysql (will try for %s, %s between attempts)", timeout, interval)

	if err := try.Try(connectToMySQL(connectionString), timeout, interval); err != nil {
		log.Fatal(err)
	}

	log.Printf("connected in %s", time.Now().Sub(start).Truncate(time.Millisecond))

}

// connectToMySQL returns a function which attempts to connect to a MySQL server and ping it using the connection string provided.
func connectToMySQL(connectionString string) func() error {
	return func() error {
		db, err := sqlx.Open("mysql", connectionString)
		if err != nil {
			return errors.Wrap(err, "failed to open database")
		}

		defer db.Close()

		err = db.Ping()
		if err != nil {
			return errors.Wrap(err, "couldn't ping")
		}

		return nil
	}
}
