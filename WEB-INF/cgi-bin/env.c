#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char** environ;

int main() {
    const char s[2] = "=";

    printf("Content-type: text/html\n\n");
    printf("<html><head><title>Environment Variables</title></head><body>\n");
    printf("<h1>Environment Variables</h1>\n");
    printf("<table border='1'><tr><th>Variable</th><th>Value</th></tr>\n");
    
    char **env = environ;
    while (*env) {
        char *env_var = *env;
        char *value = getenv(*env);
        char * token = strtok(*env, s);
        printf("<tr><td>%s</td><td>%s</td></tr>\n", token, value);
        env++;
    }

    printf("</table></body></html>\n");

    return 0;
}