#include <stdio.h>
#include <string.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <sys/socket.h>

#define PRINTER_IP "192.168.1.50"
#define PRINTER_PORT 9100

int main()
{
	int sock = socket(AF_INET, SOCK_STREAM, 0);
	struct sockaddr_in printer;

	printer.sin_family = AF_INET;
	printer.sin_port = htons(PRINTER_PORT);
	inet_pton(AF_INET, PRINTER_IP, &printer.sin_addr);

	if (connect(sock, (struct sockaddr*)&printer, sizeof(printer)) < 0) {
		perror("connection failed");
		return 1;
	}

	const char *data =
	      "\x1B" "E"
              "Hellorld\n"
              "\f";

	int result = send(sock, data, strlen(data), 0);
	printf("result: %d\n", result);
	printf("len data: %d\n", strlen(data));

	shutdown(sock, SHUT_WR);
	close(sock);
	return 0;
}
