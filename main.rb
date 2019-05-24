require 'dotenv/load'
require './kafka'

def start_producer
  puts 'start producer'
  kafka = Rdkafka::Config.new(CONFIG)
  producer = kafka.producer

  10.times do |i|
    puts "Producing message #{i}"
    producer.produce(
      topic: default_topic,
      payload: i.to_s,
      key: i.to_s
    ).wait
  end
end

def start_consumer(group:, instance:)
  puts "start consumer #{group}#{instance}"
  kafka = Rdkafka::Config.new(CONFIG.merge(:'group.id' => group))
  consumer = kafka.consumer

  consumer.subscribe(default_topic)

  begin
    consumer.each do |message|
      puts "Consumer #{group}#{instance} received: #{summary(message)}"
    end
  rescue Rdkafka::RdkafkaError => e
    retry if e.is_partition_eof?
    raise e
  end
end

def summary(message)
  "payload = #{message.payload}, partition = #{message.partition}, offset = #{message.offset}"
end

def default_topic
  "#{ENV['CLOUDKARAFKA_TOPIC_PREFIX']}default"
end

[
  Thread.new { start_producer },
  Thread.new { start_consumer(group: 'B', instance: 1) },
  Thread.new { start_consumer(group: 'A', instance: 1) },
  Thread.new { start_consumer(group: 'A', instance: 2) }
].each(&:join)

