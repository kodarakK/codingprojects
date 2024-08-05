#include <stdio.h>
#include <string.h>
#include <stdbool.h>

void printFile(char filename[128])
{
	char c;
	FILE *fptr = fopen(filename, "r");
	c = fgetc(fptr);
	while (c != EOF)
	{
		printf("%c", c);
		c = fgetc(fptr);
	}
	fclose(fptr);
}

void appendToFile(char filename[128])
{
	char buffer[128];
	FILE *fptr = fopen(filename, "a");
	while (buffer[0] != '.')
	{
	//	if (buffer[0] == '\\')
	//	{
	//		fprintf(fptr, buffer[1]);
	//		buffer[0] = ''; 
	//		buffer[1] = ''; 
	//	} else {
	//		buffer[0] = '\0';
	//		printf(":");
	//		fgets(buffer, sizeof(buffer), stdin);
	//		if (buffer[0] == '.')
	//			continue;
	//		fprintf(fptr, buffer);
			// printf("%s", buffer);
	//	}
		
		printf("\n:");
		fgets(buffer, sizeof(buffer), stdin);
		int counter = 0;
		bool skip = false;
		
		while (buffer[counter] != '\n')
		{
			if (!skip)
			{
				if (buffer[counter] == '\\') 
				{
					skip = true;
					continue;
				}
			} else {
				skip = false;
			}
			fprintf(fptr, buffer[counter]);
		 	counter++;
		}

	}

	printf("chao!\n");
	for (int i = 0; i < sizeof(buffer); ++i)
	{
		printf("%c", buffer[i]);
	}
	fclose(fptr);
}

int main(int argc, char *argv[])
{
	FILE *file;
	char buffer[128];
	char filename[128];
	if (argv[1] == NULL)
	{
		printf("no file specified\n");
		return 1;
	}
	strcpy(filename, argv[1]);
	file = fopen(filename, "a");
	char option = ' ';
	do 
	{
		scanf("%c", &option);
		switch(option) 
		{
			case 'p':
				printFile(filename);
				break;
			case 'e':
				appendToFile(filename);
				break;
			default: 
				printf("?\n");
				break;
		}
	} while (option != 'q');
	fclose(file);
	return 0;
}
