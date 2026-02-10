## 📘 GameVault Database Project

This project demonstrates end-to-end PostgreSQL database design workflow, from schema modeling to querying relational data using real-world game catalog scenarios.

GameVault is a relational database project designed to manage video games, their developers, and genres.
The database is built using PostgreSQL and follows proper normalization rules.

Note: This project was developed as an educational / training assignment to practice relational database design, constraints, and SQL queries using PostgreSQL.

## Database Structure

developers: Stores game development companies.

games: Stores games and links each game to its developer.

genres: Stores game genres (RPG, FPS, etc.).

game_genres: Junction table for the many-to-many relationship between games and genres.

## Relationships

One developer can create multiple games (One-to-Many).

A game can belong to multiple genres (Many-to-Many).

This project includes table creation (DDL), data insertion (DML), update, delete, and reporting queries using JOIN.
