Hablamos
========

A messaging and chat system meant to demonstrate various features of
the Elixir programming language.

## Protocol

All commands are terminated with `\n`. General errors include:

* `error command-invalid`
* `error session-terminated`

Create an account: `create <username> <password>`

* `error username-taken`
* `error username-invalid`
* `error password-invalid`
* `success`

Connect to an account: `connect <username> <password>`

* `error password-incorrect`
* `success`

Find out who you are: `whoami`

* `success <username>`
* `error unauthenticated`
