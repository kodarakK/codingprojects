#include <unistd.h>

int main()
{
	write(1, "foo\n", 4);
	write(2, "bar\n", 4);
}
