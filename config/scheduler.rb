require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

puts 'Démarrage du planificateur...'

scheduler.every '1m' do
    begin
        Flight.print
      rescue => e
        puts "Erreur lors de l'exécution de Flight.print: #{e.message}"
        puts e.backtrace
      end
end



