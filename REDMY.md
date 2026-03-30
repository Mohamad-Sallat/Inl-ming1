\# Slutprojekt i Databaser – Restaurang bokningssystem



\## Namn

Mohamad Sallat



\## Projektbeskrivning

Detta projekt är en databas i MySQL för en restaurang.  

Syftet med databasen är att hålla ordning på kunder, bord och bokningar.



I databasen kan man:

\- spara kunder

\- spara restaurangens bord

\- spara bokningar

\- automatiskt spara ett meddelande i en loggtabell när en ny bokning läggs till



Projektet är gjort på en enkel nivå så att det är lätt att förstå och lätt att redovisa.



\## Databasens tabeller



\### 1. kunder

Denna tabell sparar information om kunder.



Kolumner:

\- kund\_id

\- namn

\- telefon

\- epost



\### 2. restaurang\_bord

Denna tabell sparar information om restaurangens bord.



Kolumner:

\- bord\_id

\- bordsnummer

\- antal\_platser

\- status



\### 3. bokningar

Denna tabell sparar information om bokningar.



Kolumner:

\- bokning\_id

\- kund\_id

\- bord\_id

\- bokningsdatum

\- bokningstid

\- antal\_personer

\- skapad\_tid



\### 4. logg

Denna tabell används för att spara meddelanden automatiskt när en bokning skapas.



Kolumner:

\- logg\_id

\- meddelande

\- skapad\_tid



\## Relationer mellan tabellerna

Databasen använder primärnycklar och främmande nycklar.



\- `kund\_id` är primärnyckel i tabellen `kunder`

\- `bord\_id` är primärnyckel i tabellen `restaurang\_bord`

\- `bokning\_id` är primärnyckel i tabellen `bokningar`

\- `logg\_id` är primärnyckel i tabellen `logg`



I tabellen `bokningar` finns två främmande nycklar:

\- `kund\_id` kopplas till `kunder(kund\_id)`

\- `bord\_id` kopplas till `restaurang\_bord(bord\_id)`



Det betyder att varje bokning hör ihop med en kund och ett bord.



\## Dataintegritet

För att skydda datan används olika constraints:



\- `NOT NULL` används så att viktiga värden inte kan vara tomma

\- `UNIQUE` används så att till exempel telefonnummer och bordsnummer inte kan finnas dubbelt

\- `CHECK` används för att kontrollera att antal personer och antal platser är större än 0

\- `DEFAULT` används för att ge standardvärden, till exempel status = 'Ledigt'

\- `FOREIGN KEY` används för att koppla tabellerna rätt



Detta gör databasen säkrare och minskar risken för fel.



\## Trigger

Projektet innehåller en trigger.



Triggern körs automatiskt efter att en ny bokning har lagts till i tabellen `bokningar`.



Triggern gör två saker:

1\. den sparar ett meddelande i tabellen `logg`

2\. den uppdaterar bordets status till `Bokat`



Detta är bra eftersom databasen då kan automatisera en uppgift utan att användaren behöver göra det själv.



\## SQL-frågor

Projektet innehåller SQL-frågor med `JOIN` och `GROUP BY`.



\### JOIN

En JOIN används för att visa information från flera tabeller samtidigt.  

Till exempel kan man visa:

\- kundens namn

\- bordets nummer

\- bokningsdatum

\- bokningstid



\### GROUP BY

GROUP BY används för att analysera data.  

Till exempel kan man se:

\- hur många bokningar varje kund har gjort

\- hur många gånger varje bord har bokats



\## Varför denna struktur valdes

Jag valde denna struktur eftersom den är enkel, tydlig och passar bra för en restaurang.



Det är bättre att dela upp informationen i flera tabeller än att lägga allt i en enda tabell.  

På så sätt blir databasen mer organiserad och lättare att underhålla.



Med denna struktur undviker man också onödig upprepning av data.



\## Sammanfattning

Detta projekt visar hur man kan designa och implementera en enkel relationsdatabas i MySQL.



Databasen innehåller:

\- flera sammankopplade tabeller

\- primärnycklar och främmande nycklar

\- constraints för dataintegritet

\- en trigger för automation

\- SQL-frågor med JOIN och GROUP BY



Projektet uppfyller kraven för en enkel databaslösning och är lätt att förstå och redovisa.

