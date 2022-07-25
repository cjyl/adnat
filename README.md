
# Adnat Challenge

In this challenge created a highly simplified version of the Tanda web app from scratch using Ruby on Rails.



## As a user, I can: 

- Access landing page, will need to log in or sign up to view organisations.
- Edit user account details(opt. 1).
- Join multipul oganisations (opt. 8), or create an organisation (opt.11 -stimulus).
- Once joined, can view organisation details and shifts, or leave.
- Edit organisation details or Delete organisation. 
- Create shifts for themselves in an organisation;
- See if shift is overnight (opt.5) or cover Sunday for penalty pay (opt.6).

## Run Locally

Clone the project

```bash
git clone git@github.com:cjyl/adnat.git
cd adnat
```

Install gems

```bash
bundle:install
```

Install dependencies
```bash
yarn:install
```

Set up data base
```bash
rails db:create db:migrate db:seed
```

Start the server

```bash
rails s
```
In new tab
```bash
yarn build --watch
```
... and land on http://localhost:3000 

