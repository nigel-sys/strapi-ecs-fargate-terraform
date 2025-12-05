# Strapi Local Setup --- Task Documentation

This README documents all the steps followed to clone the Strapi repository, set up the development environment using Docker, run it locally with Postgres and Nginx, create a sample content type, and push the setup to a personal GitHub repository.

---

## Clone the Strapi Repository

`git clone https://github.com/strapi/strapi`

## Move into the project directory:

`cd strapi`

---

## Docker Setup (Strapi + Postgres + Nginx)

Make sure you have **Docker** and **Docker Compose** installed.

### 1\. Build the Docker Containers

`docker-compose build`

### 2\. Run the Docker Containers

`docker-compose up -d`

This will start three containers:

1.  **Strapi** --- CMS server (internal port 1337)

2.  **Postgres** --- database (internal port 5432)

3.  **Nginx** --- reverse proxy mapping host port 80 → Strapi

> All containers are connected to a **custom Docker network** `strapi-net`, allowing them to communicate internally by container name.

### 3\. Verify Docker Network (Optional)

`docker network inspect strapi-net`

This will show all three containers connected to the same network.

---

## Access Strapi

Open your browser at:

`http://localhost/admin`

> Nginx forwards requests from host port 80 to Strapi. You do **not** need to map Strapi directly to a host port.

---

## Stop or Re-run Containers

Stop containers:

`docker-compose stop`

Re-run containers:

`docker-compose up -d`

---

## Start the Admin Panel

Once the server is started, open:

`http://localhost/admin`

You will be prompted to create the first admin user.

---

## Create a Sample Content Type

1.  Go to **Content-Type Builder** in the admin panel.

2.  Click **Create new collection type**.

3.  Name it (example): `demo`

4.  Add fields such as:

    - `title`

    - `content`

    - `published`

5.  Save --- Strapi will restart automatically.

6.  Go to **Content Manager** and create an entry.

---

## Push the Setup to Your GitHub Repository

Initialize Git (if not already):

`git init`

Add remote:

`git remote add origin https://github.com/<your-username>/<your-repo>.git`

Add all files:

`git add .`

Commit:

`git commit -m "Initial Strapi setup with Docker, Postgres, Nginx, and custom network"`

Push:

`git push -u origin main`

Replace `<your-username>` and `<your-repo>` with your actual GitHub username and repository name.
