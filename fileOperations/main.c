#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	FILE *fptr;
	char buffer[128];
	fptr = fopen("data.txt", "a");
	printf("What to append: ");
	fgets(buffer, sizeof(buffer), stdin);
	fprintf(fptr, buffer);
	buffer[0] = '\0';
	fclose(fptr);
	return 0;


