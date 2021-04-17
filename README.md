# Identicon

This project is part of Stephen Grider's course on Elixir and Phoenix, which I am currently taking and coding along. I have created a repo for it, solely for the purpose of my own learning as I approach a new programming language. I do not present this as my own work, though I may modify it as I gain comfort in working with Elixir.

The expected results of this program, explained in more detail below, is that upon initiating the process with a given input, a user is presented with a .png file that features an Identicon that is both unique to the input value. Rather than being a randomly-generated image, the user will find that repeated instances on the same input will yield consistent results.

## Installation and Use

Clone this repository to a local directory, and ensure that you have the latest versions of Elixir via https://elixir-lang.org.

Then, open the directory in your terminal and install the necessary dependencies by running:

```
mix deps.get
```

Once the installations have completed, you are ready to run the app. Initiate the shell by running:

```
iex -S mix
```

and then initiate the process by running the following line of code, where 'input' is replaced by the word or phrase for which you want to create an Identicon.

```
Identicon.main("input")
```

The end result is a newly-created .png with the same name as your input, featuring a design that is unique to the input string. Repeated processes on the same input will yield consistent results.

# Further Documentation

This program features comments on every function. To review these, you can simply open the repository in a code editor. Alternatively, you can access the documentation via index.html.

To do this, open the root directory in your terminal, and run the following line of code to ensure the document is reawdy to be viewed:

```
mix docs
```

Once this runs successfully, run the following line of code, assuming that you are in the root directory of the repository:

```
open docs/index.html
```

This will present you with an interactive document, in which you will find the documentation of this program.
