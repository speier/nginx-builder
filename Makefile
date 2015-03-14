NAME=nginx-builder

build: clean
	@docker build -t $(NAME) .
	@docker run -v $(PWD)/output:/output $(NAME)

test: build
	@docker run -p 88:80 nginx-builder /usr/local/nginx/sbin/nginx -V

clean:
	@rm -rf output
