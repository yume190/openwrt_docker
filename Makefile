openwrt:
	docker build -t openwrt .

it_ubuntu:
	docker run -it --rm ubuntu:xenial

it_openwrt:
	docker run -it --rm openwrt
