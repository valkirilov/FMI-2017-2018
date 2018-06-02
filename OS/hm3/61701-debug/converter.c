#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

// glib C Library (GNU C Library)
// www.gnu.org/software/libc/manual/

int main(int argc, char* argv[])
{

    int fd = 0;
    int fd2 = 0;
    char buff[10];
    int count_read = 0;
    int bytes_written = 0;

    fd = open("webster.dat", O_RDONLY);
    fd2 = open("webster.txt", O_WRONLY);

    if(fd == -1) {
        printf("Error when opening file!\n");
        return 1;
    }

    while(1) {
        count_read = read(fd, buff, 10);

        if(count_read == -1) {
            printf("Error while reading..\n");
            return 3;
        }

        if(count_read == 0) {
            printf("All is ok :)");
            break;
        }

        bytes_written = write(fd2, buff, count_read);
        if(bytes_written == -1) {
            printf("Error while writting.\n");
            return 4;
        }

    }

    if(close(fd) == -1) {
        printf("Error when closing file!\n");
        return 2;
    }

    return 0;
}