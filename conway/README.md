# Jeu de la vie
Cette implémentation du jeu de la vie utilise un zipper (qui contient
lui même des zippers) et des listes paresseuses. L'évaluation se fait
au moyen d'une comonade.

## Référence

*   [Comonadic functional attribute evaluation](http://www.cs.ioc.ee/tfp-icfp-gpce05/tfp-proc/03num.pdf)

## Dépendance

*   OCaml 4.02 (et sûrement avant...)

## Compilation

*   `make` : génère l'exécutable
*   `make clean`: nettoie les fichiers compilés

## Lancement complet

```
make
./game largeur hauteur
```
> Il faut utiliser enter pour passer d'un état à un autre.
