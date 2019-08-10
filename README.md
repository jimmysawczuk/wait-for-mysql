# wait-for-mysql

[![Go Report Card](https://goreportcard.com/badge/github.com/jimmysawczuk/wait-for-mysql)](https://goreportcard.com/report/github.com/jimmysawczuk/wait-for-mysql)

> `wait-for-mysql` accepts a MySQL (`go-mysql-driver`) connection string and attempts to connect to the provided database until successful or until a timeout period is reached.

## Example

```bash
$ wait-for-mysql -timeout 60s -interval 2s 'root:passwd@tcp(localhost:3306)/my_db'
```
