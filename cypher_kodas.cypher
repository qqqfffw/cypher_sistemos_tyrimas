//1
MATCH (n) DETACH DELETE n;

//Grafo kūrimas
CREATE ({name:"Elektromobilis"})-[:YRA]->({name:"Automobilis"})
       -[:YRA]->({name:"Transporto priemonė"})
       -[:YRA]->({name:"Inžinerinis įrenginys"});

MATCH p=(n)-[r]->(m) RETURN p;

//užklausa
MATCH (a {name:"Elektromobilis"}), (b {name:"Inžinerinis įrenginys"})
RETURN EXISTS((a)-[:YRA*]->(b)) AS teisingas;

//kontrolinė užklausa
MATCH (a {name:"Automobilis"}), (b {name:"Elektromobilis"})
RETURN EXISTS((a)-[:YRA*]->(b)) AS teisingas;


//2



MATCH (n) DETACH DELETE n;
CREATE (g {name:"Gydytojas"})-[:YRA]->({name:"Medicinos darbuotojas"}),
      ({name:"Chirurgas"})-[:YRA]->(g),
      ({name:"Kardiologas"})-[:YRA]->(g);
MATCH p=(n)-[r]->(m) RETURN p;

MATCH (a {name:"Chirurgas"}), (b {name:"Kardiologas"})
RETURN EXISTS((a)-[:YRA*]->(b)) AS teisingas;

MATCH (a {name:"Chirurgas"}), (b {name:"Medicinos darbuotojas"})
RETURN EXISTS((a)-[:YRA*]->(b)) AS teisingas;

//3
MATCH (n) DETACH DELETE n;


CREATE (mi {name:"Mineralas"}),
       (me {name:"Metalas"}),
       ({name:"Deimantas"})-[:YRA]->(mi),
       ({name:"Aliuminio lydinys"})-[:YRA]->(me),
       (mi)-[:NESUTAMPA]->(me);


MATCH p=(n)-[r]->(m) RETURN p;


MATCH (a {name:"Deimantas"})-[:YRA*0..]->(X)
      -[:NESUTAMPA]-(Y)<-[:YRA*0..]-(b {name:"Aliuminio lydinys"})
RETURN count(*) > 0 AS teisingas;


MATCH (a {name:"Deimantas"})-[:YRA*0..]->(X)
      -[:NESUTAMPA]-(Y)<-[:YRA*0..]-(b {name:"Mineralas"})
RETURN count(*) > 0 AS teisingas;


//4
MATCH (n) DETACH DELETE n;

CREATE (p:Faktas {name:"Lakmuso popierius paraudo"})
       -[:YRA]->(q {name:"Tirpale yra rūgšties"});

MATCH p=(n)-[r]->(m) RETURN p;

MATCH (:Faktas)-[:YRA*]->(q {name:"Tirpale yra rūgšties"})
RETURN count(*) > 0 AS teisingas;


//5
MATCH (n) DETACH DELETE n;


CREATE (s {name:"Sieros junginys"}),
       (t {name:"Tirpsta vandenyje"}),
       (r {name:"Stipri rūgštis"}),
       (s)-[:NESUTAMPA]->(t),
       (c:Konstanta {name:"c"}),
       (c)-[:YRA]->(s),
       (c)-[:YRA]->(r);

MATCH p=(n)-[r]->(m) RETURN p;

MATCH (c:Konstanta)-[:YRA*]->({name:"Stipri rūgštis"})
MATCH (c)-[:YRA*0..]->(X)-[:NESUTAMPA]-(Y)<-[:YRA*0..]-({name:"Tirpsta vandenyje"})
RETURN count(DISTINCT c) > 0 AS teisingas;

