CREATE TABLE CHALLENGES (
    challenge_id INT,
    hacker_id INT FOREIGN KEY REFERENCES Hackers(hacker_id)
);