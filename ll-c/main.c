#include <stdio.h>
#include <stdlib.h>

typedef struct {
  void *next;
  int data;
} Node;

Node *head = NULL;

// add node
Node *addNode(int data) 
{
	Node *new = NULL;
	 // list empty
	 if (head == NULL) 
	 {
		 new = malloc(sizeof(Node));
		 if (new == NULL) 
			 return NULL;
		 new->data = data;
		 head = new;
		 new->next = NULL;
	 } else 
	 {
		new = malloc(sizeof(Node));
		if (new == NULL) 
			return NULL;
		new->data = data;
		new->next = head;
		head = new;
	 }

	 return new;

}

// remove node 
int removeNode(int data) 
{
	Node *current = head;
	Node *prev = head;
	while (current != NULL)
	{
		if (current->data == data)
		{
			// if current node is the list head
			if (current == head)
			{
				head = current->next;
			} else {
				prev->next = current->next;
				free(current);
				current = NULL;
			}

			return -1;
		}
		prev = current;
		current = current->next;
	}

	return 0;
}
// insert node
Node *insertNode(int data, int pos)
{
	Node *current = head;
	while (current != NULL && pos != 0)
	{
		pos--;
	}
	if (pos != 0)
	{
		printf("Requested position too far into list\n");
		return NULL;
	}

	Node *new = malloc(sizeof(Node));
	if (new == NULL) 
	{
		return NULL;
	}
	new->data = data;
	new->next = current->next;
	current->next = new;

	return new;

}
// print list
void printList()
{
	Node *current = head;
	while (current != NULL)
	{
		printf("%d->", current->data);
		current = current->next;
	}
	printf("\n");
}

void printMenu() 
{
  printf("You have the following options:\n");
  printf("\t1. Add a node to the list\n");
  printf("\t2. Remove a node from the list\n");
  printf("\t3. Insert node to the list\n");
  printf("\t4. Show the list\n");
  printf("\t5. Quit\n");
  return;

}

int main(int argc, char **argv) 
{
	int option = -1;
	int data = 0;
	int option2 = -1;
	Node *new = NULL;
	while (option != 5) 
	{
  		printMenu();
		int num_received = scanf("%d", &option);
		if (num_received == 1 && option > 0 && option <= 5)
		{
			switch(option)
			{
				case 1:
					// add 
					printf("what data shoud I add: ");
					scanf("%d", &data);
					new = addNode(data);
					break;

				case 2: 
					// remove 
					printf("what data shoud I remove: ");
					scanf("%d", &data);
					int suc6 = removeNode(data);
					if (!suc6)
						printf("element nogt found");
					break;
				case 3: 
					//insert
					printf("what data shoud I insert: ");
					scanf("%d", &data);
					printf("What position?: ");
					scanf("%d", &option2);
					new = insertNode(data, option2);
					if (new == NULL)
						printf("Failed to insert into list\n");
					break;

				case 4:
					//show list
					printList();
					break;
				case 5: 
					break;
			}
		}
	}
  return 0;
}
