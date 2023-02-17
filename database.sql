CREATE TABLE source(
    source_url VARCHAR(200),
    source_name VARCHAR(100),
    PRIMARY KEY(source_url)
);

CREATE TABLE locations(
    location VARCHAR(30)    PRIMARY KEY,
    iso_code VARCHAR(10),
    last_observation VARCHAR(10),
    source_url VARCHAR(200),
    FOREIGN KEY(source_url) REFERENCES source(source_url)
);

CREATE TABLE vaccinations(
    location VARCHAR(30),
    date VARCHAR(10),
    total_vaccinations INTEGER,
    people_vaccinated INTEGER,
    people_fully_vaccinated INTEGER,
    total_boosters INTEGER,
    daily_vaccinations_raw INTEGER,
    daily_vaccinations INTEGER,
    daily_vaccinations_per_million INTEGER,
    PRIMARY KEY(location, date)
    FOREIGN KEY(location) REFERENCES locations(location)
);

CREATE TABLE vaccinations_by_age_group(
    location VARCHAR(30),
    date VARCHAR(10),
    age_group varchar(10),
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    people_with_boosters_per_hundred FLOAT,
    PRIMARY KEY(location, date, age_group),
    FOREIGN KEY(location) REFERENCES locations(location)
);

CREATE TABLE vaccinations_by_manufacturer(
    location VARCHAR(30),
    date VARCHAR(10),
    vaccine VARCHAR(30),
    total_vaccinations INTEGER,
    PRIMARY KEY(location, date, vaccine),
    FOREIGN KEY(location) REFERENCES locations(location)
);

CREATE TABLE locations_vaccines_used(
    location VARCHAR(30),
    vaccine VARCHAR(30),
    PRIMARY KEY(location, vaccine),
    FOREIGN KEY(location) REFERENCES locations(location)
);

CREATE TABLE countries_vaccines_by_day(
    location VARCHAR(30),
    date VARCHAR(10),
    vaccine VARCHAR(50),
    PRIMARY KEY(location, date, vaccine),
    FOREIGN KEY(location) REFERENCES locations(location)
);

CREATE TABLE countries_source_by_day(
    location VARCHAR(30),
    date VARCHAR(10),
    source_url VARCHAR(200),
    PRIMARY KEY(location, date)
    FOREIGN KEY(location) REFERENCES locations(location)
);

CREATE TABLE us_state_vaccinations(
    date VARCHAR(10),
    state VARCHAR(30),
    total_vaccinations INTEGER,
    total_distributed INTEGER,
    people_vaccinated INTEGER,
    people_fully_vaccinated INTEGER,
    daily_vaccinations_raw INTEGER,
    daily_vaccinations INTEGER,
    daily_vaccinations_per_million INTEGER,
    share_doses_used FLOAT,
    total_boosters INTEGER,
    location VARCHAR(30),
    PRIMARY KEY(date, state)
    FOREIGN KEY(location) REFERENCES locations(location)
);