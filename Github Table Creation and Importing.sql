/*Run the following code into PGAdmin once you have downloaded the github data and placed it in a public directory. 
Make sure in the FROM statement that you include your public directory for the COPY statement to work properly.*/

CREATE TABLE github(
    topic VARCHAR(255),
    user_name VARCHAR(255),
    repo_name VARCHAR(255),
    repo_link VARCHAR(255),
    star_count INT);
    
COPY github
FROM 'C:\Users\Public\github_data.csv'
WITH (FORMAT CSV, HEADER);