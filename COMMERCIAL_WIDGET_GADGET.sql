-- 1.R�CUP�RER TOUS LES PRODUITS.
SELECT * FROM PRODUITS	

-- 2.R�CUP�RER TOUS LES CLIENTS.
SELECT * FROM CLIENTS 

--3.R�CUP�RER TOUTES LES COMMANDES.
SELECT * FROM COMMANDES

--4.R�CUP�RER TOUS LES D�TAILS DE LA COMMANDE.
SELECT * FROM DETAILS_DE_LA_COMMANDE

--5.R�CUP�RER TOUS LES TYPES DE PRODUITS.
SELECT * FROM TYPES_DE_PRODUITS

/*6.R�CUP�REZ LES NOMS DES PRODUITS QUI ONT �T� COMMAND�S PAR AU MOINS UN CLIENT,
AINSI QUE LA QUANTIT� TOTALE DE CHAQUE PRODUIT COMMAND�.*/

SELECT ProductName, SUM (DETAILS_DE_LA_COMMANDE.Quantity ) AS QUANTITE_COMMANDE
from PRODUITS
INNER JOIN
DETAILS_DE_LA_COMMANDE
ON PRODUITS.ProductID = DETAILS_DE_LA_COMMANDE.ProductID
GROUP BY ProductName
HAVING SUM (DETAILS_DE_LA_COMMANDE.Quantity ) >= 1

/*7.R�CUP�REZ LES NOMS DES CLIENTS QUI ONT PASS� UNE COMMANDE CHAQUE JOUR DE LA SEMAINE, 
AINSI QUE LE NOMBRE TOTAL DE COMMANDES PASS�ES PAR CHAQUE CLIENT. */

SELECT CustomerName, count (COMMANDES.OrderID) as COMMANDES_PASSEES
FROM CLIENTS
INNER JOIN COMMANDES
ON
CLIENTS.CustomerID = COMMANDES.CustomerID
GROUP BY CustomerName
HAVING COUNT(DISTINCT DATEPART(WEEKDAY, COMMANDES.CustomerID))=7


/* 8.R�CUP�REZ LES NOMS DES CLIENTS AYANT PASS� LE PLUS DE COMMANDES, 
AINSI QUE LE NOMBRE TOTAL DE COMMANDES PASS�ES PAR CHAQUE CLIENT.*/


SELECT CustomerName, COUNT (COMMANDES.OrderID) AS NOMBRE_DE_COMMANDES
FROM CLIENTS
INNER JOIN COMMANDES
ON CLIENTS.CustomerID = COMMANDES.CustomerID
GROUP BY CustomerName
ORDER BY COUNT (COMMANDES.OrderID)

/* 9.R�CUP�REZ LES NOMS DES PRODUITS LES PLUS COMMAND�S,
AINSI QUE LA QUANTIT� TOTALE DE CHAQUE PRODUIT COMMAND�. */


SELECT ProductName, COUNT (DETAILS_DE_LA_COMMANDE.OrderID) AS NOMBRE_DE_COMMANDES ,
SUM (DETAILS_DE_LA_COMMANDE.Quantity) AS QUANTITE_TOTALE_DE_CHAQUE_PRODUIT_COMMANDE
FROM PRODUITS 
INNER JOIN DETAILS_DE_LA_COMMANDE
ON PRODUITS.ProductID = DETAILS_DE_LA_COMMANDE.ProductID
GROUP BY ProductName
ORDER BY SUM (DETAILS_DE_LA_COMMANDE.Quantity) DESC

/* 10.	R�CUP�RER LES NOMS DES CLIENTS AYANT PASS� COMMANDE POUR AU MOINS UN WIDGET. */
SELECT CustomerName
FROM CLIENTS
INNER JOIN COMMANDES
ON CLIENTS.CustomerID = COMMANDES.CustomerID
INNER JOIN DETAILS_DE_LA_COMMANDE
ON COMMANDES.OrderID = DETAILS_DE_LA_COMMANDE.OrderID
INNER JOIN PRODUITS
ON DETAILS_DE_LA_COMMANDE.ProductID = PRODUITS.ProductID
WHERE PRODUITS.ProductTypeName = 'Widget'
GROUP BY CustomerName

/* 11.	R�CUP�REZ LES NOMS DES CLIENTS AYANT PASS� COMMANDE 
D'AU MOINS UN WIDGET ET D'AU MOINS UN GADGET, AINSI QUE LE CO�T TOTAL DES WIDGETS
ET GADGETS COMMAND�S PAR CHAQUE CLIENT.*/

SELECT CustomerName,
SUM (CASE WHEN PRODUITS.ProductTypeName = 'Widget' 
THEN PRODUITS.Price * DETAILS_DE_LA_COMMANDE.Quantity ELSE 0 END) AS TOTAL_WIDGETS,
SUM (CASE WHEN PRODUITS.ProductTypeName = 'Gadget' 
THEN PRODUITS.Price * DETAILS_DE_LA_COMMANDE.Quantity ELSE 0 END) AS TOTAL_GADGETS
FROM CLIENTS
INNER JOIN COMMANDES
ON CLIENTS.CustomerID = COMMANDES.CustomerID
INNER JOIN DETAILS_DE_LA_COMMANDE
ON COMMANDES.OrderID = DETAILS_DE_LA_COMMANDE.OrderID
INNER JOIN PRODUITS
ON DETAILS_DE_LA_COMMANDE.ProductID = PRODUITS.ProductID
WHERE PRODUITS.ProductTypeName IN ('Widget', 'Gadget')
GROUP BY CustomerName

/* 12.	R�CUP�REZ LES NOMS DES CLIENTS AYANT PASS� COMMANDE D'AU MOINS UN GADGET,
AINSI QUE LE CO�T TOTAL DES GADGETS COMMAND�S PAR CHAQUE CLIENT.*/

SELECT CustomerName, sum (PRODUITS.Price * DETAILS_DE_LA_COMMANDE.Quantity) AS COUT_TOTAL_GADGETS
FROM CLIENTS
INNER JOIN COMMANDES
ON CLIENTS.CustomerID = COMMANDES.CustomerID
INNER JOIN DETAILS_DE_LA_COMMANDE
ON COMMANDES.OrderID = DETAILS_DE_LA_COMMANDE.OrderID
INNER JOIN PRODUITS
ON DETAILS_DE_LA_COMMANDE.ProductID = PRODUITS.ProductID
WHERE PRODUITS.ProductTypeName = 'Gadget'
GROUP BY CustomerName

/*13.	R�CUP�REZ LES NOMS DES CLIENTS AYANT PASS� COMMANDE D'AU MOINS UN DOOHICKEY, 
AINSI QUE LE CO�T TOTAL DES DOOHICKEY COMMAND�S PAR CHAQUE CLIENT.*/

SELECT CustomerName, sum (PRODUITS.Price * DETAILS_DE_LA_COMMANDE.Quantity) AS COUT_TOTAL_DOOHICKEY
FROM CLIENTS
INNER JOIN COMMANDES
ON CLIENTS.CustomerID = COMMANDES.CustomerID
INNER JOIN DETAILS_DE_LA_COMMANDE
ON COMMANDES.OrderID = DETAILS_DE_LA_COMMANDE.OrderID
INNER JOIN PRODUITS
ON DETAILS_DE_LA_COMMANDE.ProductID = PRODUITS.ProductID
WHERE PRODUITS.ProductTypeName = 'Doohickey'
GROUP BY CustomerName

/*14.R�CUP�REZ LES NOMS DES CLIENTS QUI ONT PASS� UNE COMMANDE CHAQUE JOUR DE LA SEMAINE, 
AINSI QUE LE NOMBRE TOTAL DE COMMANDES PASS�ES PAR CHAQUE CLIENT.*/

SELECT CustomerName, count (COMMANDES.OrderID) as COMMANDES_PASSEES
FROM CLIENTS
INNER JOIN COMMANDES
ON
CLIENTS.CustomerID = COMMANDES.CustomerID
GROUP BY CustomerName
HAVING COUNT(DISTINCT DATEPART(WEEKDAY, COMMANDES.CustomerID))=7


/*15.R�CUP�REZ LE NOMBRE TOTAL DE WIDGETS ET DE GADGETS COMMAND�S PAR CHAQUE CLIENT, 
AINSI QUE LE CO�T TOTAL DES COMMANDES.*/

SELECT CustomerName, SUM ( PRODUITS.Price * DETAILS_DE_LA_COMMANDE.Quantity) AS
COUT_TOTAL_DES_COMMANDES,
SUM (CASE WHEN PRODUITS.ProductTypeName = 'Widget' 
THEN PRODUITS.Price * DETAILS_DE_LA_COMMANDE.Quantity ELSE 0 END) AS TOTAL_WIDGETS,
SUM (CASE WHEN PRODUITS.ProductTypeName = 'Gadget' 
THEN PRODUITS.Price * DETAILS_DE_LA_COMMANDE.Quantity ELSE 0 END) AS TOTAL_GADGETS
FROM CLIENTS
INNER JOIN COMMANDES
ON CLIENTS.CustomerID = COMMANDES.CustomerID
INNER JOIN DETAILS_DE_LA_COMMANDE
ON COMMANDES.OrderID = DETAILS_DE_LA_COMMANDE.OrderID
INNER JOIN PRODUITS
ON DETAILS_DE_LA_COMMANDE.ProductID = PRODUITS.ProductID
WHERE PRODUITS.ProductTypeName IN ('Widget', 'Gadget')
GROUP BY CustomerName