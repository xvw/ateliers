/* Interpréteur Brainfuck 
 * Xavier Van de Woestyne <xaviervdw at gmail dot com>
 * Ce code est pour le domaine publique (logique)
 * Réalisé en 2015
 */


#include <stdio.h>
#include <stdlib.h>
#define MEMORY_SIZE 30000

/* Définition du tableau d'octets*/
int memory[MEMORY_SIZE];
int cursor;

/* Trouve l'après boucle */
int match_bracket(int i, char* expr) {
  int count_bracket;
  count_bracket = 0;
  while( *(expr + i) != '\0') {
    if (*(expr + i) == '[') count_bracket += 1;
    if (*(expr + i) == ']') {
      if (count_bracket == 0) return i;
      else count_bracket -= 1;
    }
    i += 1;
  }
  return -1;
}

/* Routine principale */
int execute(int i, char* expr) {
  char current, in;
  current = *(expr + i);
  switch(current) {
  case '\0': return -1;
  case ']': return i;
  case '+' : memory[cursor] += 1; break;
  case '-' : memory[cursor] -= 1; break;
  case '>' : cursor += 1;         break;
  case '<' : cursor -= 1;         break;
  case '.' :
    printf("%c", *(memory + cursor));
    break;
  case ',' :
    scanf("%c", &in);
    memory[cursor] = in;
    break;
  case '[':
    if (*(memory + cursor) == 0 ) {
      i = match_bracket(i+1, expr);
    } else {
      execute(i+1, expr); 
      i -= 1;
    }
    break;
  }
  return execute(i+1, expr);
}
/* Wrapper pour la routine principale */
void bf(char* e) { execute(0, e); }


/* Routine principale */
int main(int argc, char** argv) {
  if (argc != 2 ) {
    printf("usage : ./brainfuck <BFCode here>\n");
    return EXIT_FAILURE;
  }
  bf(*(argv + 1)); 
  printf("\n");
  return EXIT_SUCCESS;
}
