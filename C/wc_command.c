#include <unistd.h> 
#include <stdlib.h> 
#include <fcntl.h>
#include <stdio.h> 
#include <err.h> 

int main(int argc, char* argv[])
{
	if (argc != 2)
	{
		err(2, "Wrong number of arguments\n"); 
	}

	int fd1;
	char buff; 
	int lines = 0;  
	int words = 0; 
	int chars = 0; 

	if( (fd1 = open(argv[1], O_RDONLY)) == -1 )
	{
		err(2, "Could not open file\n"); 
	}
//we use simple definition for word
	while(read(fd1, &buff, sizeof(buff)) == sizeof(buff))
	{
		if(buff == '\n')
		{
			lines++;
			words++; 
		}
		if(buff == ' ')
		{
			words++; 
		}
		chars++; 
	}

	printf("File %s has:\n %d number of lines\n %d number of words\n %d number of chars\n", argv[1], lines, words, chars); 
	
	close(fd1); 
	
	exit(0); 
}
