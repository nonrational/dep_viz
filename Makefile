docker-run:
	docker build -t dep_viz .
	docker run -it -p 4040:4040 dep_viz
