version_tag = `scm-status | jq --raw-output '.tags[0]' | cut -c 2-`

default:
	docker build -t jimmysawczuk/wait-for-mysql .
	docker tag jimmysawczuk/wait-for-mysql:latest jimmysawczuk/wait-for-mysql:$(version_tag)
	docker push jimmysawczuk/wait-for-mysql:latest
	docker push jimmysawczuk/wait-for-mysql:$(version_tag)
