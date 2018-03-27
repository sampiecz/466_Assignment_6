###########################################################
# CSCI 466 - Assignment 6 - Spring 2018                   #
#                                                         #
# Progammer: Sam Piecz                                    #
# Z-ID: Z1732715                                          #
# Section: 3                                              #
# TA: Rajarshi Sen                                        #
# Date Due: March 26, 2018                                # 
# Purpose: SQL queries from multiple tables               # 
###########################################################

# Commented out for Rajs ease of grading 

# Use database
# USE z1732715;

# Generate Tables
# \. alexamaraload.sql

# 1
SELECT o.LastName, o.FirstName, ms.BoatName, ms.BoatType FROM MarinaSlip ms JOIN Owner o ON ms.OwnerNum = o.OwnerNum ORDER BY o.LastName LIMIT 10;

# 2
SELECT o.LastName, o.FirstName, COUNT(ms.BoatName) "NumBoats" FROM Owner o JOIN MarinaSlip ms ON o.OwnerNum = ms.OwnerNum GROUP BY o.LastName HAVING COUNT(ms.BoatName) > 1 LIMIT 10;

# 3
SELECT sr.Description, o.LastName FROM ServiceRequest sr, Owner o, MarinaSlip ms WHERE ms.SlipID = sr.SlipID AND ms.OwnerNum = o.OwnerNum GROUP BY sr.Description LIMIT 10;

# 4
SELECT sc.CategoryDescription, sr.CategoryNum FROM ServiceCategory sc JOIN ServiceRequest sr ON sc.CategoryNum = sr.CategoryNum GROUP BY sc.CategoryDescription LIMIT 10;

# 5
SELECT o.LastName, o.FirstName, o.City, o.State, m.Name FROM Owner o JOIN Marina m JOIN MarinaSlip ms ON o.OwnerNum = ms.OwnerNum AND ms.MarinaNum = m.MarinaNum GROUP BY o.LastName ORDER BY o.City, o.LastName LIMIT 10;

# 6
SELECT m.Name, SUM(ms.RentalFee) FROM Marina m JOIN MarinaSlip ms ON ms.MarinaNum = m.MarinaNum GROUP BY m.Name LIMIT 10;

# 7
SELECT ServiceID "ID", EstHours "Estimated Hours", SpentHours "Spent Hours", EstHours - SpentHours "Difference" FROM ServiceRequest LIMIT 10;

# 8
SELECT o.LastName, ms.BoatName, ms.Length FROM Owner o JOIN MarinaSlip ms ON o.OwnerNum = ms.OwnerNum WHERE ms.Length <= 30 LIMIT 10;

# 9
SELECT ms.BoatName, sr.NextServiceDate FROM MarinaSlip ms JOIN ServiceRequest sr ON ms.SlipID = sr.SlipID GROUP BY ms.BoatName LIMIT 10;

# 10
SELECT ms.BoatName, o.LastName, ms.SlipID, m.Name FROM Owner o JOIN MarinaSlip ms JOIN Marina m ON o.OwnerNum = ms.OwnerNum AND ms.MarinaNum = m.MarinaNum ORDER BY ms.BoatName, m.Name LIMIT 10;

