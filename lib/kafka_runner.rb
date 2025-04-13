require_relative "../config/environment"
require_relative "../app/consumers/kafka_consumer"

KafkaConsumer.new(topic: "student_created").listen
