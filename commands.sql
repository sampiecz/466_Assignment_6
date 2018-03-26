# I already created the DB using source command \. alexamaraload.sql
# I also ran SHOW DATABASES; and, USE z1732715 prior to that.
 
# 1
# List all owner names last, first and the name and type of their 
# boat and in alphabetic order of last name

SELECT o.LastName, o.FirstName, ms.BoatName, ms.BoatType FROM MarinaSlip ms JOIN Owner o LIMIT 10;

+----------+-----------------+-------------+-------------+
| LastName | FirstName       | BoatName    | BoatType    |
+----------+-----------------+-------------+-------------+
| Adney    | Bruce and Doris | Anderson II | Sprite 4000 |
| Anderson | Bill            | Anderson II | Sprite 4000 |
| Blake    | Mary Jane       | Anderson II | Sprite 4000 |
| Elend    | Mary and Bill   | Anderson II | Sprite 4000 |
| Feenstra | Daniel          | Anderson II | Sprite 4000 |
| Juarez   | Maria           | Anderson II | Sprite 4000 |
| Kelly    | Alyssa          | Anderson II | Sprite 4000 |
| Smith    | Peter           | Anderson II | Sprite 4000 |
| Smeltz   | Becky and Dave  | Anderson II | Sprite 4000 |
| Trent    | Ashton          | Anderson II | Sprite 4000 |
+----------+-----------------+-------------+-------------+
10 rows in set (0.00 sec)

# 2
# List all of the owners who have more than one boat, and how many 
# boats they own. 


MariaDB [z1732715]> SELECT o.LastName, o.FirstName, COUNT(ms.BoatName) "NumBoat(s)" FROM Owner o JOIN MarinaSlip ms ON o.OwnerNum = ms.OwnerNum GROUP BY o.LastName LIMIT 10;
+----------+-----------------+------------+
| LastName | FirstName       | NumBoat(s) |
+----------+-----------------+------------+
| Adney    | Bruce and Doris |          2 |
| Anderson | Bill            |          1 |
| Blake    | Mary Jane       |          2 |
| Elend    | Mary and Bill   |          1 |
| Feenstra | Daniel          |          2 |
| Juarez   | Maria           |          1 |
| Kelly    | Alyssa          |          1 |
| Smeltz   | Becky and Dave  |          1 |
| Smith    | Peter           |          1 |
| Trent    | Ashton          |          1 |
+----------+-----------------+------------+
10 rows in set (0.00 sec)

# 3
# For each service request, list the Description of the request as 
# well as the Owner last name.

MariaDB [z1732715]> SELECT sr.Description, o.LastName FROM ServiceRequest sr, Owner o, MarinaSlip ms WHERE ms.SlipID = sr.SlipID AND ms.OwnerNum = o.OwnerNum LIMIT 10;
+-------------------------------------------------------------------------------------------------+----------+
| Description                                                                                     | LastName |
+-------------------------------------------------------------------------------------------------+----------+
| Canvas leaks around zippers in heavy rain. Install overlap around zippers to prevent leaks.     | Blake    |
| Air conditioner periodically stops with code indicating low coolant level. Diagnose and repair. | Adney    |
| Fuse on port motor blown on two occasions. Diagnose and repair.                                 | Elend    |
| Oil change and general routine maintenance (check fluid levels, clean sea strainers etc.).      | Feenstra |
| Engine oil level has been dropping drastically. Diagnose and repair.                            | Adney    |
| Air conditioning unit shuts down with HHH showing on the control panel.                         | Juarez   |
| Electric-flush system periodically stops functioning. Diagnose and repair.                      | Smeltz   |
| Engine overheating. Loss of coolant. Diagnose and repair.                                       | Adney    |
| Heat exchanger not operating correctly.                                                         | Adney    |
| Canvas severely damaged in windstorm. Order and install new canvas.                             | Kelly    |
+-------------------------------------------------------------------------------------------------+----------+
10 rows in set (0.00 sec)

# 4
# For each service category list the Category Description and how 
# many service requests there are for each category.

MariaDB [z1732715]> SELECT sc.CategoryDescription, sr.CategoryNum FROM ServiceCategory sc JOIN ServiceRequest sr ON sc.CategoryNum = sr.CategoryNum GROUP BY sc.CategoryNum LIMIT 10;
+---------------------------------------------------+-------------+
| CategoryDescription                               | CategoryNum |
+---------------------------------------------------+-------------+
| Routine engine maintenance                        |           1 |
| Engine repair                                     |           2 |
| Air conditioning                                  |           3 |
| Electrical systems                                |           4 |
| Fiberglass repair                                 |           5 |
| Canvas installation                               |           6 |
| Canvas repair                                     |           7 |
| Electronic systems (radar, GPS, autopilots, etc.) |           8 |
+---------------------------------------------------+-------------+
8 rows in set (0.00 sec)


# 5.
# List all of the owners (name, city, and state) and the Name of the 
# marina where they keep their boat, in alphabetic order of city and 
# within city of last name.
 
MariaDB [z1732715]> SELECT o.LastName, o.FirstName, o.City, o.State, m.Name FROM Owner o JOIN  Marina m JOIN MarinaSlip ms ON o.OwnerNum = ms.OwnerNum AND ms.MarinaNum = m.MarinaNum ORDER BY o.City, o.LastName LIMIT 10;
+----------+-----------------+-------------+-------+-------------------+
| LastName | FirstName       | City        | State | Name              |
+----------+-----------------+-------------+-------+-------------------+
| Trent    | Ashton          | Bay Shores  | FL    | Alexamara Central |
| Adney    | Bruce and Doris | Bowton      | FL    | Alexamara East    |
| Adney    | Bruce and Doris | Bowton      | FL    | Alexamara Central |
| Blake    | Mary Jane       | Bowton      | FL    | Alexamara South   |
| Blake    | Mary Jane       | Bowton      | FL    | Alexamara East    |
| Kelly    | Alyssa          | Bowton      | FL    | Alexamara Central |
| Anderson | Bill            | Glander Bay | FL    | Alexamara East    |
| Smeltz   | Becky and Dave  | Glander Bay | FL    | Alexamara Central |
| Feenstra | Daniel          | Kaleva      | FL    | Alexamara East    |
| Feenstra | Daniel          | Kaleva      | FL    | Alexamara Central |
+----------+-----------------+-------------+-------+-------------------+
10 rows in set (0.00 sec)

# 6.
# What is the total rental fee amount for each Marina in the 
# database?

MariaDB [z1732715]> SELECT m.Name, SUM(ms.RentalFee) FROM Marina m JOIN MarinaSlip ms ON ms.MarinaNum = m.MarinaNum GROUP BY m.Name LIMIT 10;
+-------------------+-------------------+
| Name              | SUM(ms.RentalFee) |
+-------------------+-------------------+
| Alexamara Central |          16500.00 |
| Alexamara East    |          16200.00 |
| Alexamara South   |           8400.00 |
+-------------------+-------------------+
3 rows in set (0.00 sec)

# 7.
# For each service request list the estimated hours, spent hours and 
# the difference. Just list the ServiceId and the hours information. 
# All the columns should be renamed.

MariaDB [z1732715]> SELECT ServiceID "ID", EstHours "Estimated Hours", SpentHours "Spent Hours", SpentHours - EstHours "Difference" FROM ServiceRequest AS Difference LIMIT 10;
+----+-----------------+-------------+------------+
| ID | Estimated Hours | Spent Hours | Difference |
+----+-----------------+-------------+------------+
|  1 |            8.00 |        3.00 |      -5.00 |
|  2 |            4.00 |        2.00 |      -2.00 |
|  3 |            2.00 |        0.00 |      -2.00 |
|  4 |            1.00 |        0.00 |      -1.00 |
|  5 |            2.00 |        0.00 |      -2.00 |
|  6 |            1.00 |        1.00 |       0.00 |
|  7 |            3.00 |        0.00 |      -3.00 |
|  8 |            2.00 |        0.00 |      -2.00 |
|  9 |            4.00 |        1.00 |      -3.00 |
| 10 |            8.00 |        0.00 |      -8.00 |
+----+-----------------+-------------+------------+
10 rows in set (0.00 sec)

# 8.
# List the last name of the owners (and their boat's name) who own a 
# boat that is 30 feet long or shorter.

MariaDB [z1732715]> SELECT o.LastName, ms.BoatName, ms.Length FROM Owner o JOIN MarinaSlip ms ON o.OwnerNum = ms.OwnerNum WHERE ms.Length <= 30 LIMIT 10;
+----------+--------------+--------+
| LastName | BoatName     | Length |
+----------+--------------+--------+
| Feenstra | Gypsy        |     30 |
| Elend    | Anderson III |     30 |
| Adney    | Bravo        |     25 |
| Kelly    | Chinook      |     25 |
| Trent    | Listy        |     25 |
| Smith    | Mermaid      |     30 |
+----------+--------------+--------+
6 rows in set (0.00 sec)

# 9.
# For each boat, list the name and next service date
#

MariaDB [z1732715]> SELECT ms.BoatName, sr.NextServiceDate FROM MarinaSlip ms JOIN ServiceRequest sr ON ms.SlipID = sr.SlipID LIMIT 10;
+--------------+-----------------+
| BoatName     | NextServiceDate |
+--------------+-----------------+
| Krispy       | 2013-07-17      |
| Anderson II  | 2013-07-12      |
| Anderson III | 2013-07-12      |
| Gypsy        | 2013-07-16      |
| Anderson II  | 2013-07-13      |
| Axxon IV     | 2020-12-31      |
| Karvel       | 2020-12-31      |
| Bravo        | 2013-07-13      |
| Bravo        | 2013-07-17      |
| Chinook      | 2013-07-16      |
+--------------+-----------------+
10 rows in set (0.00 sec)

# 10.
# List each boat name, the owner's last name, the slip number and 
# Marina name in alphabetic order of boat name within the alphabetic 
# order of the marina name.
 
MariaDB [z1732715]> SELECT ms.BoatName, o.LastName, ms.SlipID, m.Name FROM Owner o JOIN MarinaSlip ms JOIN Marina m ON o.OwnerNum = ms.OwnerNum AND ms.MarinaNum = m.MarinaNum ORDER BY m.Name LIMIT 10;
+-------------+----------+--------+-------------------+
| BoatName    | LastName | SlipID | Name              |
+-------------+----------+--------+-------------------+
| Bravo       | Adney    |      6 | Alexamara Central |
| Chinook     | Kelly    |      7 | Alexamara Central |
| Listy       | Trent    |      8 | Alexamara Central |
| Mermaid     | Smith    |      9 | Alexamara Central |
| Axxon II    | Feenstra |     10 | Alexamara Central |
| Karvel      | Smeltz   |     11 | Alexamara Central |
| Anderson II | Adney    |      1 | Alexamara East    |
| Our Toy     | Anderson |      2 | Alexamara East    |
| Escape      | Blake    |      3 | Alexamara East    |
| Gypsy       | Feenstra |      4 | Alexamara East    |
+-------------+----------+--------+-------------------+
10 rows in set (0.00 sec)

