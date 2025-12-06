// chat_server.c

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <string.h>

#define PortNumber 9999 //7777
#define MaxConnects 8
#define BuffSize 256
#define ConversationLen 3
#define Host "localhost"

void report(const char* msg, int terminate) {
  perror(msg);
  if (terminate) exit(-1);
}

int main() {
  // create a socket and get file descriptor
  int fd = socket(AF_INET, SOCK_STREAM, 0);

  // if the socket connection fails, report the error
  // and terminate the server
  if (fd < 0) report("socket", 1);	//terminate

  // bind the server's local address in memory
  struct sockaddr_in saddr;
  memset(&saddr, 0, sizeof(saddr));		// clear bytes
  saddr.sin_family = AF_INET;
  saddr.sin_addr.s_addr = htonl(INADDR_ANY);	// host to network endian
  saddr.sin_port = htons(PortNumber);		// for listening

  // if the bind fails, terminate the connection
  if (bind(fd, (struct sockaddr *) &saddr, sizeof(saddr)) < 0)
	  report("bind", 1);	//terminate

  // listen for client requests, up to MaxConnects
  if (listen(fd, MaxConnects) < 0) report("listen", 1);	// terminate

  fprintf(stderr, "Listening on port %i for clients...\n", PortNumber);

  // accept a client's request
  while (1) {
    struct sockaddr_in caddr;	// client address
    int len = sizeof(caddr);	// client address length, could change

    int client_fd = accept(fd, (struct sockaddr*) &caddr, (socklen_t*) &len);  // accepts blocks

    if (client_fd < 0) {
      report("accept", 0); // regardless of the issue, don't terminate
      continue;
    } // end if

    // read from client
    int i;

    // note: only reading from client three times, need to fix
    for (i = 0; i < ConversationLen; i++) {
      char buffer[BuffSize + 1];
      memset(buffer, '\0', sizeof(buffer));
      int count = read(client_fd, buffer, sizeof(buffer));
      
      if (count > 0) {
        puts(buffer);
	write(client_fd, buffer, sizeof(buffer)); // echo confirmation
      } // end if
    } // end for

    // break connection
    close(client_fd);
  } // end while

  return 0;
}
