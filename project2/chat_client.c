// chat_client.c

#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>

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
  // initialize the username and file descriptor for socket connection
  char username[99];
  int sockfd = socket(AF_INET, SOCK_STREAM, 0);

  // request a username
  printf("Enter a username: ");

  // get the username
  scanf("%s", username);

  // output the username back to the user
  printf("Welcome %s!\n", username);

  // terminate connection if file descriptor is under 0
  if (sockfd < 0) report("socket", 1);

  // get host address
  struct hostent* hptr = gethostbyname(Host);
  
  if (!hptr) report("gethostbyname", 1);
  if (hptr->h_addrtype != AF_INET) report("bad address family", 1);

  // configure server address and connect to the server
  struct sockaddr_in saddr;
  memset(&saddr, 0, sizeof(saddr));
  saddr.sin_family = AF_INET;
  saddr.sin_addr.s_addr = ((struct in_addr*) hptr->h_addr_list[0])->s_addr;
  saddr.sin_port = htons(PortNumber);

  // attempt to connect to server
  if (connect(sockfd, (struct sockaddr*) &saddr, sizeof(saddr)) < 0)
	  report("connect", 1);

  // send messages to server
  puts("Connected to server, now type...\n");
  char buffer[1024];
  strcat(username, ": ");
  int write_stat, read_stat;
  
  while (1) {
    puts(username);
    scanf("%s", buffer);
    write_stat = write(sockfd, buffer, strlen(buffer));

    if (write_stat < 0) report("ERROR", 1);
    
    read_stat = read(sockfd, buffer, 1023);

    if (read_stat < 0) report("ERROR", 1);

    printf("Message received: %s", buffer);
  } // end while

  // end connection
  puts("Client done!");
  close(sockfd);

  return 0;
}
