create table user (
    email VARCHAR(200) PRIMARY KEY
);

create table workout (
    email VARCHAR(200),
    day DATE,
    PRIMARY KEY (email, day)
    FOREIGN KEY (email) REFERENCES user (email)
);
