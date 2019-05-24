require 'bundler/setup'
require 'rdkafka'

CONFIG = {
  'bootstrap.servers' => ENV['CLOUDKARAFKA_BROKERS'],
  'group.id'          => 'cloudkarafka-example',
  'sasl.username'     => ENV['CLOUDKARAFKA_USERNAME'],
  'sasl.password'     => ENV['CLOUDKARAFKA_PASSWORD'],
  'security.protocol' => 'SASL_SSL',
  'sasl.mechanisms'   => 'SCRAM-SHA-256'
}
