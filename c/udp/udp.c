#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>

int main()
{
  printf("udp message sender\n");
  const char* message = "Does this work with any message lenght???";

  int s = socket(AF_INET, SOCK_DGRAM, 0);

  struct sockaddr_in sin;
  
  sin.sin_family = AF_INET;
  /* port gsm */
  sin.sin_port = htons(12345);
  /* ip gsm */
  sin.sin_addr.s_addr = inet_addr("192.168.1.31");

  for (int i = 0; i < 10; i++) {
    sendto(s, message, strlen(message), 0, (struct sockaddr *)&sin, sizeof(sin));
  }

}
