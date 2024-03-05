# Tourify

![Microverse](https://img.shields.io/badge/Microverse-blueviolet)

> This is an app in which you can reserve a tour, create a tour, delete a tour and show all your reserved tours. This app was created by separating the Fron-End and the Back-End into two repositories. This is the repository of the back-end API.

## Front-End repository

[Link to Fron-end Repository](https://github.com/marilirulita/Booking-Tours-Front-End)

## Live Demo

[Link to live Demo](https://tourify-app.netlify.app)

## Built With

- Rails, Ruby, Devise, Cancancan, Rspec, SQL, Capybara.

## Prerequisites

- Make sure Rails and Ruby are installed.
- Make sure PostgreSQL is installed.

## Setup Project

- Open your terminal.
- Clone repo by running this command: `git clone git@github.com:marilirulita/Booking-Tours.git`
- Navigate to project folder: `cd Booking-Tours`
- Install dependencies with `bundle install`
- Create the database: `rails db:create`
- Create database tables and schema: `rails db:migrate`
- You can create an admin user and some tours as examples: `rails db:seed`

## Usage

- Run with `rails server`

- You can get all available tours with an HTTP request like this:

```
const result = await fetch('http://127.0.0.1:3000/tours');
const resultJson = await result.json();
```

- You have to create a user to interact with api:

==In this example you create an user with name, email and password==.
```
const response = await fetch('http://127.0.0.1:3000/users', {
    method: 'POST',
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
    },
    redirect: 'follow',
    referrerPolicy: 'no-referrer',
    body: JSON.stringify({
      "name": "user name",
      "email": "user email",
      "password": "user password",
    }),
  });
```

- You have to log in to delete a tour you create before or create a new one:

==In this response you will get data. You need to pay atention in the token for make moves deleting or creeating tours==.

```
const loginResponse = await fetch('http://127.0.0.1:3000/auth/login', {
    method: 'POST',
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
    },
    redirect: 'follow',
    referrerPolicy: 'no-referrer',
    body: JSON.stringify({
      "email": "user email",
      "password": "user password"
      }),
  });
```

- To create a tour

==In Authrization you need to add the token data gived in login response==.

```
const response = await fetch('http://127.0.0.1:3000/tours', {
    method: 'POST',
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      Authorization: loginResponse.token,
    },
    redirect: 'follow',
    referrerPolicy: 'no-referrer',
    body: JSON.stringify({
      "title": "tour name",
      "duration": integer,
      "description": "text description",
      "city": "city name",
      "cost": integer,
      "photo": "url of a picture",
  }),
  });
```

- To delete a tour made for your user

```
const response = await fetch('http://127.0.0.1:3000/tours/id#', {
    method: 'DELETE',
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      Authorization: loginResponse.token,
    },
  });
```

- You can sign up for a tour from other users:

```
const response = await fetch('http://127.0.0.1:3000/user_tours', {
    method: 'POST',
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      Authorization: loginResponse.token,
    },
    redirect: 'follow',
    referrerPolicy: 'no-referrer',
    body: JSON.stringify({
      persons_number: integer,
      reservation_date: 'date',
      tour_id: integer,
  }),
  });
```

## Run the tests

`rspec spec`

## Authors

👤 **Mar Bautista**

- GitHub: [marilirulita](https://github.com/marilirulita)
- LinkedIn: [mar bautista](https://www.linkedin.com/in/marbautista/)
- Twitter: [@marylirulita](https://twitter.com/marylirulita)

👤 **Santiago Cárdenas**

- GitHub: [@Santiago Cárdenas](https://github.com/Santiago220991)
- LinkedIn: [Santiago Cárdenas](https://www.linkedin.com/in/alexandersantiagocardenas/)
- Twitter: [@SanCardenas10](https://twitter.com/SanCardenas10)

👤 **Mahmoud Makhlouf**

- GitHub: [@devMahmoud](https://github.com/devMahmoud)
- LinkedIn: [Mahmoud Makhlouf](https://www.linkedin.com/in/mahmoud-abdelkader-makhlouf/)

---

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Original design idea by [Murat Korkmaz on Behance](https://www.behance.net/gallery/26425031/Vespa-Responsive-Redesign).

## 📝 License

This project is [MIT](./MIT.md) licensed.
