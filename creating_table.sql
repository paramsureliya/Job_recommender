CREATE DATABASE job_data;
USE job_data;

CREATE TABLE job_skills_table (
  id INT AUTO_INCREMENT PRIMARY KEY,
  job_link VARCHAR(255),
  job_skills VARCHAR(50)
);

LOAD DATA LOCAL INFILE '/home/ec2-user/.cache/kagglehub/datasets/asaniczka/1-3m-linkedin-jobs-and-skills-2024/job_skills.csv'
INTO TABLE job_skills_table
FIELDS TERMINATED BY ','          -- Fields are separated by commas.
OPTIONALLY ENCLOSED BY '"'        -- Optionally, fields may be enclosed in quotes (important for `job_skills`).
LINES TERMINATED BY '\n'          -- Rows are separated by newlines.
IGNORE 1 ROWS                     -- Skip the header row.
(job_link, job_skills);           -- Map CSV columns to table columns.

CREATE TABLE job_postings_table (
    id INT AUTO_INCREMENT PRIMARY KEY,               -- Primary key for the job posting
    job_link VARCHAR(255) NOT NULL,                   -- URL link to the job posting on LinkedIn
    last_processed_time DATETIME(6),                     -- Timestamp of the last time the job posting was processed
    got_summary CHAR(1) DEFAULT 'F',                              -- Indicates whether the job summary was successfully extracted
    got_ner CHAR(1) DEFAULT 'F',                                  -- Indicates whether Named Entity Recognition (NER) was performed
    is_being_worked CHAR(1) DEFAULT 'F',                          -- Indicates if the job posting is currently being worked on
    job_title VARCHAR(255),                           -- Title of the job listing
    company VARCHAR(255),                             -- Company offering the job
    job_location VARCHAR(255),                        -- Location of the job
    first_seen DATETIME,                              -- Timestamp when the job posting was first seen
    search_city VARCHAR(255),                         -- City used as search criterion for job postings
    search_country VARCHAR(255),                      -- Country used as search criterion for job postings
    search_position VARCHAR(255),                     -- Position used as search criterion for job postings
    job_level VARCHAR(50),                            -- Job position level (e.g., entry-level, senior, etc.)
    job_type VARCHAR(50)                             -- Type of job (e.g., onsite, hybrid)
);

LOAD DATA LOCAL INFILE '/home/ec2-user/.cache/kagglehub/datasets/asaniczka/1-3m-linkedin-jobs-and-skills-2024/linkedin_job_postings.csv'
INTO TABLE job_postings_table
FIELDS TERMINATED BY ','          -- Fields are separated by commas.
OPTIONALLY ENCLOSED BY '"'        -- Fields may optionally be enclosed by quotes.
LINES TERMINATED BY '\n'          -- Rows are separated by newlines.
IGNORE 1 ROWS                     -- Skip the header row.
(job_link, last_processed_time, got_summary, got_ner, is_being_worked, job_title, company, job_location, first_seen, search_city, search_country, search_position, job_level, job_type);

