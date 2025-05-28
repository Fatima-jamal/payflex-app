-- Create a users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert dummy users
INSERT INTO users (username, email, password)
VALUES 
('fatimaj', 'fatima@example.com', 'pass123'),
('usmanahmed', 'usman@example.com', 'nodejs123'),
('zaraq', 'zara@example.com', 'dockerpass'),
('ali_dev', 'ali@example.com', 'tf@support'),
('ayeshak', 'ayesha@example.com', 'metabase321');
