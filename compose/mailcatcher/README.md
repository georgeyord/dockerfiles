Mailcatcher in Docker container using docker-compose
=====================================================

**[MailCatcher](http://mailcatcher.me/) Catches mail and serves it through a dream.**

MailCatcher runs a super simple SMTP server which catches any message sent to it to display in a web interface. Run mailcatcher, set your favourite app to deliver to smtp://127.0.0.1:1025 instead of your default SMTP server, then check out http://127.0.0.1:1080 to see the mail that's arrived so far.

![MailCatcher interface](http://f.cl.ly/items/3w2T1p0F3g003b2i1F2z/Screen%20shot%202011-06-23%20at%2011.39.03%20PM.png)

## Quick Start
`docker-compose up -d` to run MailCatcher server in the background

> _Link the container to another container and use the mailcatcher SMTP port `1025` via a ENV variable like `$MAILCATCHER_PORT_1025_TCP_ADDR`._
