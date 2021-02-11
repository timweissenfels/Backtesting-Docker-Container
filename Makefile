default: image

image:
	docker build -f Dockerfile \
	-t quantbase-jupyter \
	--compress .
