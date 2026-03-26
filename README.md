Inl-ming1

Inläming 1 , databaser , Bokhandel
Naman Mohamad Sallat YH25
ER-digram har jag sakpats en bild för ER-diagram för bokhandel.
Entiteter och attribut
bok:
-ISBN PK
-titel
-Författare
-Pris
-Lagerstatus
Kund
-Kund_ID PK
-Namn
-Epost
-Telefon
-Adress
Bestallning
-Order_ID PK
-Kund_ID = Kund FK
-Datum
-Totalbelopp
Orderrad
-Orderrad_ID PK
-Orderrad_ID = Bestallning FK
-ISBN = BOK FK
-Antal
-Pris_vid_Köp
Relationer:

En Kund kan göra flera Bestallning
1 till många (Kund 1 - Bestallning N)
En Bestallning består av flera Orderrad
1 till många (Bestallning 1 - Orderrad N)
En bok kan förekomma i flera Orderrad
1 till många (bok 1 - Orderrad N)
Relationsmodell:
Relationsmodellen som används i SQL ser ut så här:
-Bok(ISBN PK, titel, författare, pris, lagerstatus)
-Kund(Kund_ID PK, namn, epost, telefon, adress)
-Bestallning(Order_ID PK, kund_id FK=kod, datum, totalbelopp)
-Orderrad(orderrad_ID PK, Order_ID FK=bestallning, ISBN FK=bok, antal, pris_vid_köp)

Primärnyklar:
-ISBN anväds som PK för BOk eftersom ISBN är unikt för en bok.
-Kund_ID, Order_DI och Orderrad_ID är artificiella heltalnycklar (AUTO_INCREMENT) för att ge srabila enkla identifierare.
Främmande nycklar:
-Kund_ID i bestallning pekar på kund (Varje bestallning hör till exakt en kund.
-Order_ID och ISBN i Orderrad pekar på bestallning respektiv BOK (Vearje Orderrad kopplar ihop enen viss beställning med en viss bok.



# Inlämning 2 

## Namn
Mohamad Sallat

Det här är fortsättningen på min inlämning 1.
Jag har fortsatt att arbeta med databasen **bokhandel**.

I den här uppgiften har jag lagt till mer testdata och gjort flera SQL-frågor och funktioner i databasen.

## Det jag har gjort
Jag har:

- lagt till fler kunder, beställningar och orderrader
- hämtat data med `SELECT`
- filtrerat data med `WHERE`
- sorterat data med `ORDER BY`
- uppdaterat data med `UPDATE`
- tagit bort data med `DELETE`
- använt `ROLLBACK` för att ångra ändringar
- använt `INNER JOIN` och `LEFT JOIN`
- använt `GROUP BY` och `HAVING`
- skapat ett index på e-post
- lagt till en constraint så att pris inte får vara 0 eller mindre
- skapat en loggtabell
- skapat två triggers

## Trigger 1
Den första triggern minskar lagersaldot när en ny orderrad läggs till.

## Trigger 2
Den andra triggern loggar när en ny kund registreras i databasen.

## Backup och restore
Jag har också gjort backup och restore i MySQL Workbench.

För backup använde jag:
**Server -> Data Export**

För restore använde jag:
**Server -> Data Import**

Efter restore testade jag databasen med `SELECT` för att se att tabeller och data fanns kvar.
