Hablamos
========

A messaging and chat system meant to demonstrate various features of
the Elixir programming language.

## Protocol

All commands are terminated with `\n`. General errors include:

* `error command-invalid`
* `error session-terminated`

Create an account: `create <username> <password>`

* `success`
* `error username-taken`
* `error username-invalid`
* `error password-invalid`

Connect to an account: `connect <username> <password>`

* `success`
* `error password-incorrect`

Find out who you are: `whoami`

* `success <username>`
* `error unauthenticated`

Fetch contacts: `contacts[ online]`

* `success <contact1>,<contact2>,...`
* `error unauthenticated`

Add a contact: `add <username>`

* `success`
* `error user-not-found`

Remove a contact: `remove <username>`

* `success`
* `error user-not-found`

Message a user: `send <username> <message>`

* `success`
* `error user-not-found`
