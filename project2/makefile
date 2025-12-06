all: chat_server chat_client

chat_server: chat_server.c
	gcc -o chat_server -std=c99 -Wall -O1 chat_server.c

chat_client: chat_client.c
	gcc -o chat_client -std=c99 -Wall -O1 chat_client.c

clean:
	rm chat_server
	rm chat_client
