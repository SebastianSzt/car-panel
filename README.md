# Car-Panel

A Ruby on Rails application for managing car informations.

## Features

- User authentication with Devise
- Brand and model management
- Admin panel
- Pagination

## Prerequisites

- Ruby 3.x
- Rails 7.x
- PostgreSQL
- Node.js
- Yarn
- Mailcatcher (for handling emails in development)

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/SebastianSzt/car-panel.git
   cd car-panel
   ```

2. **Install Dependencies**

   Install Ruby gems:

   ```bash
   bundle install
   ```

   Install JavaScript dependencies:

   ```bash
   yarn install
   ```

3. **Setup the Database**

   Create and migrate the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Start the Rails Server**

   ```bash
   rails server
   ```

   Open `http://127.0.0.1:3000` in your web browser.

## Usage

1. **User Operations**

   - **Browse Brands and Models:** Unauthenticated users can view the list of brands and models.
   - **Edit Brands and Models:** Authenticated users can view and edit brands and models.

2. **Admin Panel Operations**

   - **Add a Brand:** Click "New Brand" to create a new brand.
   - **Delete a Brand:** Click "Destroy" to remove a brand.
   - **Add a Model:** Use the form in the admin panel to add a new model to a brand.
   - **Delete a Model:** Click "Destroy" next to the model you wish to remove.
   - **Import Data:** Click "Import Data" (currently not implemented).
   - **Delete Data:** Click "Delete Data" to remove all data from database.

3. **Access the Admin Panel**

   - Log in as an admin user to manage brands and models.
   - Navigate to `http://127.0.0.1:3000/admin` to access the admin panel.

## Authentication

  - **Regular User:** Can be created via Devise registration.
  - **Admin User:**  To access the admin panel, you need to create an admin user in the console. Follow these steps:

   ```bash
   rails console
   ```

   ```ruby
   User.create(email: 'email', password: 'password', role: 'admin')
   exit
   ```
