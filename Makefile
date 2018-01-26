default:
	GOOS=linux GOARCH=amd64 go build -o build/wait-for-mysql .
	docker build -t jimmysawczuk/wait-for-mysql .
	docker push jimmysawczuk/wait-for-mysql
	rm -rf build
