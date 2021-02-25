SELECT 'CREATE DATABASE weather' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'weather')\gexec
