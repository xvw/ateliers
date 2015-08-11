/* Compteur de caractères
 * Xavier Van de Woestyne <xaviervdw at gmail dot com>
 * Ce code est pour le domaine publique (logique)
 * Réalisé en 2015
 */


#include <stdio.h>
#include <stdlib.h>
#define ASCIILEN 128


/* Effectue un rapport des caractères utilisés */
void charcount(char* phrase) {
  int compteur[ASCIILEN] = {0}, i;
  for(i = 0; phrase[i] != '\0'; i++) {
    compteur[((int) phrase[i])] += 1;
  }
  for(i = 0; i < ASCIILEN; i++) {
    if (compteur[i] > 0 ) {
      printf("[%c] a été utilisé %d fois\n", (char) i, compteur[i]);
    }
  }
}

/* Routine principale */
int main(int argc, char** argv) {
  if (argc != 2 ) {
    printf("usage : ./charcount \"<phrase>\"\n");
    return EXIT_FAILURE;
  }
  charcount(*(argv + 1)); 
  return EXIT_SUCCESS;
}
