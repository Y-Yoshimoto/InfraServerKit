NAME=smbDocker
VERSION=0.3

build:
	docker build -t alpine-smb .

restart:
	docker stop smb-test && docker rm smb-test
	docker run -d -p 8139:139 -p 8445:445 --name smb-test alpine-smb

rebuild:
	docker build -t alpine-smb .
	docker stop smb-test && docker rm smb-test
	docker run -d -p 8139:139 -p 8445:445 --name smb-test alpine-smb