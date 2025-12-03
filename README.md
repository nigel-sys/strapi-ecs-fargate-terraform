# Strapi Local Setup — Task Documentation

This README documents all the steps followed to clone the Strapi repository, run it locally, create a sample content type, and push the setup to a personal GitHub repository.

## Clone the Strapi Repository

```bash
git clone https://github.com/strapi/strapi
```

## Move into the project directory:

```bash
cd strapi
```

## Install Dependencies

Strapi uses Yarn, so install all dependencies with:

```bash
yarn install
```

## Run Strapi Locally

Start the development server:

```bash
yarn develop
```

This will:

Build the admin panel and Start Strapi on: http://localhost:8080/admin

## Start the Admin Panel

Once the server is started, open: http://localhost:8080/admin

You will be prompted to create the first admin user.

## Create a Sample Content Type

Go to Content-Type Builder in the admin panel.

Click Create new collection type.

- Name it (example): demo

Add fields such as:

- title

- content

- published

Save and let Strapi restart.

Go to Content Manager and create an entry.

## Push the Setup to Your GitHub Repository

Initialize Git (if not already):

```bash
git init
```

Add remote:

```bash
git remote add origin https://github.com/<your-username>/<your-repo>.git
```

Add all files:

```bash
git add .
```

Commit:

```bash
git commit -m "Initial Strapi setup"
```

Push:

```bash
git push -u origin main
```

Replace `<your-username>` and `<your-repo>` with your actual GitHub username and repository name.
