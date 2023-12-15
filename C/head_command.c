#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <err.h> 

int main(int argc, char* argv[])
{
	if(argc != 2)
	{
		errx(2, "Wrong number of arguments\n"); 
	}
  
	int fd1; 
	int i = 0;
	char buff; 

	if((fd1 = open(argv[1], O_RDONLY)) == -1)
	{
		err(2, "Could not open file\n");
	}
	while (read(fd1, &buff, sizeof(buff)) == sizeof(buff))
	{
		if(c == '\n')
		{
			i = i + 1; 
		}

		if (write(1, &buff, sizeof(buff)) == -1)
		{
			err(2, "Could not write in file\n"); 
		}

		if (i == 10)
		{
			break;
		}
	}
	close(fd1); 
	exit(0); 
}
