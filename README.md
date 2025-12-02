# Inl-ming1 


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

-

