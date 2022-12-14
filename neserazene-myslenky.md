Existovalo by github repo, ktere bude obsahovat metadata - zdroj upstreamu a potrebnou kucharku
(package_info.yaml, spec file) pro zabalickovani programu. Zde by maintaineri nahravali sve zmeny,
ktere by se promitaly pomoci webhooku na server, ktery by nasledne zmeny poslal na COPR.


### science-packaging

Bude zalozen `science-packaging` FAS ucet a COPR skupina. Pod touto skupinou budou dostupny veskere
baliky.


### PR

Packager muze aktualizovat/vytvaret nove baliky tak, ze vytvori PR, ktere bude upravovat pouze
kod, ktery se tyka daneho baliku. Do niceho jineho nezasahuje


### CI

CI nejdriv zjisti, jestli PR nezasahuje do niceho jineho, nez do jedne podslozky. Dale
zjisti, jestli sedi username autora a maintainera v yaml souboru. Pote zjisti, jestli uspely
vsechny COPR buildy skrz Packit. Pokud vse uspeje, muze maintainer mergnout PR (nebo bude pingnut
spravce projektu, aby zkotroloval, jestli packager nedela nic nekaleho).


### Packit

Pri PR se zkusi pustit packit proti specifikovanym chrootum a pevne daneho chrootu, pro ktery musi
uspet vsechny buildy.

Jak pustit testy jen pro dany balik v podslozce? Mozna identifiery? Nejaky skript, ktery by
automaticky generoval .packit.yaml soubor resp. identifiery v nem pokazde, co nekdo vytvori PR
s novym balikem. Pokud by packit podporoval monorepo - potom by to bylo OK.


### Vymazani baliku

Asi pomoci smazani slozky v GH repu -> spusti se skript, ktery smaze balicek z COPRu.


### Struktura repa s baliky

```
GH repo
│
│   README.md
│   .packit.yaml
│   .requred-chroots.txt
│   etc.    
│
└───repositories
    │
    └───program1
    │   │   package_info.yaml
    │   │   package.spec
    │
    │
    └───program2
        │   ...

```

Specfile by mohlo byt mozne generovat - zminit v dokumentaci.


### Ukazka `package_info.yaml` souboru

```yaml
maintainers:
  maintainer_github_nickname:
    emails:
      - email1
      - email2
    name: jmeno
  maintainer_friend_nick:
    emails:
      - email1
    name: jmeno

upstream:
  url: some-url odkud se bude stahovat
  version: tag name basically

autoupdate: true
  
build:
  - f37
  - f36
  - centos
  
notify_on_fail:
  - f36
  - centos
```


### Issue repository

Existovala by nejaka issue repository, ktera by si uchovavala informace o neuspesnych buildech.

```
GH Issue repo
│
│   README.md
│   etc.    
│
└───issues
    │
    └───program1.yaml
    │
    │
    └───program2.yaml
    |   ...

```


#### Ukazka `program1.yaml`

```yaml
failed:
  f35:
    - results: url
    - actual_version: 1.1
    - upstream_version: 1.4
  f37:
    - results: url
    - actual_version: 1.3
    - upstream_version: 1.4
```


## Jednotlive tooly


### scipa

Hlavni tool, ktery bude obsahovat logiku pro reseni ruznych veci - parsovani yamlu, checkovani
issue repa apod... cronjoby pote muzou vyuzit jeho funkcionalitu

Use cases:
  - clean issue repository
  - zkus udelat update repozitare


### Listener

Tool, ktery bude bezet jako GH action -> jakmile se da do repa push, zaktivuje se a posle provedene
zmeny do COPRu


### fsp

Docasne reseni pro instalaci baliku, aby uzivatele nemuseli jak blazni furt davat enable na kazdy
package a pak ho stahovat -> tohle to udela naraz. Jednoduchy shell script.
