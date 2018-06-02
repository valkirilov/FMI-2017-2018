#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

int get_filesize(int file_descriptor) {
    int length = lseek(file_descriptor, 0, SEEK_END) + 1;
    lseek(file_descriptor, 0, SEEK_SET);
    return length;
}

int find_closest_word_position(int file_descriptor, int current_position)
{
    char buffer[1];
    int count_read = 0;

    lseek(file_descriptor, current_position, SEEK_SET);

    // Go left to find a word separator
    while(1) {
        count_read = read(file_descriptor, buffer, 1);

        if(count_read == -1) {
            write(STDOUT_FILENO, "Error while reading.\n", 21);
            return 3;
        }

        if (buffer[0] == '\0') {
            return current_position+1;
        }
        else {
            current_position--;
            lseek(file_descriptor, current_position, SEEK_SET);
        }
    }
}

const char* read_word(int file_descriptor, int current_position) {
    char buffer[1];
    int count_read = 0;
    int start_position = current_position;
    const char* word = "";

    lseek(file_descriptor, current_position, SEEK_SET);

    // Go right to find a word separator
    while(1) {
        count_read = read(file_descriptor, buffer, 1);

        if(count_read == -1) {
            write(STDOUT_FILENO, "Error while reading.\n", 21);
            return 3;
        }

        if (buffer[0] == '\n') {
            int word_length =  current_position - start_position;
            lseek(file_descriptor, start_position, SEEK_SET);

            word = (char*) malloc(sizeof(char) * word_length);
            count_read = read(file_descriptor, word, word_length);

            // Skip the new line separator
            count_read = read(file_descriptor, buffer, 1);

            return word;
        }
        else {
            current_position++;
            lseek(file_descriptor, current_position, SEEK_SET);
        }
    }
}

void read_description(int file_descriptor) {
    char buffer[1];
    int count_read = 0;

    // Go left to find a word separator
    while(1) {
        count_read = read(file_descriptor, buffer, 1);

        if(count_read == -1) {
            write(STDOUT_FILENO, "Error while reading.\n", 21);
            return 3;
        }
        else if (count_read == 1) {
            if (buffer[0] == '\0') {
                return;
            }
            else {
                write(STDOUT_FILENO, buffer, 1);
            }
        }
    }
}

int binary_search(int file_descriptor, int left, int right, char* search_word) {

   if (right >= left) {
        int middle = left + (right - left) / 2;

        int current_position = find_closest_word_position(file_descriptor, middle);

        char* found_word = read_word(file_descriptor, current_position);
        int compare_words = strcmp(search_word, found_word);
        free(found_word);

        if (compare_words == 0) {
            read_description(file_descriptor);
            return 1;
        }
        else if (compare_words < 0) {
            // If element is smaller alphabetically, go to the left
            return binary_search(file_descriptor, left, middle-1, search_word);
        }
        else if (compare_words > 0) {
            // Else go to the right
            return binary_search(file_descriptor, middle+1, right, search_word);
        }
   }

   return -1;
}

int main(int argc, char* argv[])
{
    if (argc != 3) {
        write(STDOUT_FILENO, "Provide correct input params.\n", 30);
        return 5;
    }

    char *dictionary_filename = argv[1];
    char *search_word = argv[2];

    int file_descriptor = open(dictionary_filename, O_RDONLY);
    if(file_descriptor == -1) {
        write(STDOUT_FILENO, "Error when opening file.\n", 25);
        return 1;
    }

    int file_length = get_filesize(file_descriptor);
    int result = binary_search(file_descriptor, 0, file_length, search_word);

    if (result == -1) {
        write(STDOUT_FILENO, "Word not found.\n", 16);
        return 4;
    }

    if(close(file_descriptor) == -1) {
        write(STDOUT_FILENO, "Error when closing file.\n", 25);
        return 2;
    }

    return 0;
}