require 'kafka'

class KafkaConsumer
  def initialize(topic:)
    @kafka = Kafka.new(["127.0.0.1:9092"], client_id: "student-ms")
    @topic = topic
    @group_id = "student-ms-consumer"
  end

  def listen
    consumer = @kafka.consumer(group_id: @group_id)
    consumer.subscribe(@topic)

    puts "Listening to #{@topic} topic..."
    
    consumer.each_message do |message|
      puts "Received the message #{message.value}"
      handle_message(JSON.parse(message.value))
    end
  rescue => e
    puts "There seems to be an error: #{e}"
    retry
  end


  private

  def handle_message(payload)
    name = payload['name']
    branch = payload['branch']
    phone_number = payload['phone_number']
    year_of_study = payload['year_of_study']
    email = payload['email']

    Student.create!(name: name,
                          branch: branch,
                          phone_number: phone_number,
                          year_of_study: year_of_study,
                          email: email
                         )

    puts "Student has been created successfully"
  rescue => e
    puts "ERROR: #{e}"
  end
end
