.PHONY: clean build

build: clean
	buildah unshare -- ./build.sh

clean:
	-buildah rm warsaw-banking
