Here is a simple flow chart:

```mermaid
graph TD
    W[Welcome Page]--get all restaurant data and get location permission-->E[Explore Page]
    E[Explore Page]--get detail restaurant data-->D[Detail Page]
    E[Explore Page]--get favorite restaurants data-->F[Favorite Page]
    F[Favorite Page]--get detail restaurant data-->D[Detail Page]
    D[Detail Page]--add restaurant to favorite-->F[Favorite Page]
```

```mermaid
graph TD
    Vegcation-->Model
    Vegcation-->Pages
    Vegcation-->Helpers
    Vegcation-->Themes
```

```mermaid
erDiagram
    MENU ||--|{ RESTAURANT : places
```
