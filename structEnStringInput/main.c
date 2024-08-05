#include <stdio.h>
#include <string.h>

typedef struct {
	char name[32];
	int age;
} Person;

int main() 
{
	Person p1, p2;
	strcpy(p1.name, "John");
	p1.age = 31;

	printf("name: %s, age: %d\n", p1.name, p1.age);

	char name[32];
	int age;

	printf("name: ");

	if (!fgets(name, sizeof(name), stdin))
		printf("failed to read input");
	else 
		name[strcspn(name, "\n")] = '\0';

	strcpy(p2.name, name);
	printf("age: ");
	scanf("%d", &age);

	p2.age = age;

	printf("name: %s, age: %d\n", p2.name, p2.age);
	return 0;
}
