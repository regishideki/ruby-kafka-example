# How to run

- run a Kafka cluster https://customer.cloudkarafka.com
- go to `details` menu, download the `connection details` to this project and
  rename it to `.env`
- run `docker build -t ruby-kafka`
- run `docker run ruby-kafka ruby main.rb`
